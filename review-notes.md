# Review Notes — 2026-07-19

Code review of the current state of the project. Ordered by severity.
Nothing here has been changed in the code — this is a checklist to work through.

---

## 0. Habit to build first

```
terraform init
terraform validate
terraform fmt -recursive
```

`validate` catches syntax and reference errors without touching AWS. Run it after
every edit. Several items below would have shown up instantly.

Note: `validate` only checks syntax and types. `terraform plan` (which calls AWS)
will surface a second wave of issues that validate cannot see. That's normal.

---

## 1. Blocking errors — won't parse or plan

### No module has an `outputs.tf`  ← biggest structural gap

A module is a black box. Nothing escapes it unless declared as an output.
Every cross-module reference is currently broken:

| Location | Broken reference |
|---|---|
| `vpc.tf:15` | `module.aws_vpc_module.id` |
| `ec2.tf:5` | `module.aws_vpc_module.orion_security_group` |
| `ec2.tf:26` | `module.s3.arn` |

Two separate problems in each:

1. `aws_vpc_module` is the *filename inside* the module, not the module name.
   Reference by the **module block label** → `module.vpc`, `module.orion-s3-bucket`.
2. Even with the right name, `.id` / `.arn` don't exist until declared:

```hcl
# vpc-module/outputs.tf
output "vpc_id" {
  value = aws_vpc.orion_vpc.id
}
```

Needed for: vpc (vpc_id, subnet ids, sg id), s3 (bucket arn), rds, alb, asg.

### Empty resource name
`vpc.tf:14` — `resource "aws_route_table" ""`. Won't parse.
Also: `route-table-module/` now exists — use it here instead of an inline resource.

### Type mismatch
`vpc.tf:12` — passes string `"0.0.0.0/0"`, variable is declared `map(string)`.

---

## 2. Networking — the conceptual part worth slowing down on

### ~~CIDR plan is broken~~ — DONE 2026-07-19

Was: VPC `10.0.0.0/24` with all three subnets overlapping it, public set to `0.0.0.0/0`.

Now `10.1.0.0/16` with six non-overlapping `/24`s, two AZs per tier:

```
app  1a  10.1.1.0/24     app  1b  10.1.11.0/24
db   1a  10.1.2.0/24     db   1b  10.1.22.0/24
pub  1a  10.1.3.0/24     pub  1b  10.1.33.0/24
```

**The three rules a subnet CIDR must satisfy** (all three, not just one):

1. **Valid block** — starts on a multiple of its own size.
   `/24` → any third octet. `/20` → third octet divisible by 16. `/16` → third octet 0.
   So `10.1.3.0/20` is impossible: a 4,096-address block can't start at address 768.
2. **Inside the VPC** — `10.2.0.0/20` fails against a `10.1.0.0/16` VPC. The second
   octet is part of the network portion of a `/16`, so changing it lands in a
   different network entirely. Same class of mistake as `0.0.0.0/0`.
3. **No overlap with siblings** — `10.1.0.0/20` spans `10.1.0.0`–`10.1.15.255` and
   would swallow the app and db subnets.

While learning: make every subnet a `/24`. Third octet becomes the subnet ID, no
boundary math. 256 addresses each, 251 usable (AWS reserves 5 per subnet).

### NAT gateway is wrong
`vpc-module/aws_vpc_module.tf:59` passes `vpc_id`, which is not an argument on
`aws_nat_gateway`. It needs:
- `subnet_id` — must be a **public** subnet
- `allocation_id` — from an `aws_eip`

*Why:* it lives in public space so it can reach the internet; private subnets
route outbound traffic **through** it.

### Route tables do nothing yet
The module creates a table with no routes and no associations — an empty container.
Still needed:

- public table → route `0.0.0.0/0` to the **internet gateway**, associated with public subnets
- private table → route `0.0.0.0/0` to the **NAT gateway**, associated with app subnets
- db subnets → typically no internet route at all

### Security group is too open / too shared
`vpc-module/aws_vpc_module.tf:73` allows SSH from `0.0.0.0/0`.
One shared SG for everything also defeats the point of three tiers.

Production pattern is a chain, each referencing the previous by ID:

```
ALB SG      ← 80/443 from 0.0.0.0/0
App SG      ← app port from ALB SG only
DB SG       ← 5432 from App SG only
```

---

## 3. Compute / DB / ALB

### EC2
- **No `subnet_id`** (`ec2-module/aws_ec2_module.tf`) — without it the instance lands
  in the default VPC, not the one being built.
- Swap `security_groups` → **`vpc_security_group_ids`**. `security_groups` takes SG
  *names* and is legacy EC2-Classic behavior.

### ASG
- No `launch_template` (`asg-module/aws_asg_module.tf`) — it has no idea what to launch.
- Design question: with an ASG you generally **don't** also create a standalone
  `aws_instance`. The launch template replaces it.

### ALB
- `alb-module/aws_alb_module.tf:3` — name uses `_`. ALB names allow only
  alphanumerics and hyphens (max 32 chars).
- Also needs `subnets`, `security_groups`, a target group, and a listener to
  actually route anything.

### RDS
- `engine_version = "18.3-R1"` is not a valid Postgres version string.
- Needs `db_subnet_group_name`, otherwise it won't land in the private DB subnets.
- **Password `"admin"` is under the 8-char minimum AND is a hardcoded secret in git.**
  Move to a variable marked `sensitive = true`, fed from `TF_VAR_rds_password`.
  Never commit `.tfvars`.

### S3 policy ARN
`ec2.tf:30` — `PutObject`/`DeleteObject` act on *objects*, so the resource needs
`"${module.orion-s3-bucket.arn}/*"`. Bucket-level and object-level ARNs are
different things.

---

## 4. Cleanup

- `aws_iam.tf` creates a role that S3 assumes — S3 doesn't assume roles that way.
  Looks like leftover experimentation. Probably delete.
- IAM is scattered across three files (`aws_iam.tf`, `iam_policy.tf`, `ec2.tf`).
  README calls for an `iam/` module — consolidate.
- `variable.tf` holds a `locals` block, not variables, and `s3_bucket_name` there is
  unused (`s3.tf` hardcodes it). Rename to `locals.tf` and actually reference it.
- No `backend.tf`, despite README promising remote state. Add early — S3 backend
  with versioning.
- Missing entirely so far: CloudWatch, launch template, target groups, listeners,
  EIP, DB subnet group, parameter group.

---

## 5. Suggested order of work

Don't fix everything at once.

1. **CIDR plan on paper**, then fix VPC + subnets
2. **Add `outputs.tf` to every module** — unblocks all cross-module wiring
3. IGW / NAT / route tables / associations — `validate` after each
4. Split security groups into the three-tier chain
5. Launch template → ASG → ALB → target group → listener
6. RDS with subnet group; secrets out of git
7. Backend, CloudWatch, IAM consolidation

---

## What's already good

- Module separation instinct is right
- Variables have descriptions, types, and sensible defaults
- `for_each` used for subnets rather than copy-paste
