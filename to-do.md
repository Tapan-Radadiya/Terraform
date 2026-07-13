# ☁️ Nimbus

> **Production-Ready AWS Infrastructure with Terraform**

Nimbus is a production-inspired Infrastructure as Code (IaC) project that provisions a secure, scalable, and modular AWS environment using Terraform. The project demonstrates Terraform best practices, reusable module design, remote state management, and production-grade AWS architecture.

---

## 🎯 Project Goals

- Learn and implement Infrastructure as Code (IaC) using Terraform
- Build reusable Terraform modules
- Provision a production-ready AWS infrastructure
- Follow AWS networking and security best practices
- Manage infrastructure using remote Terraform state
- Create a maintainable and scalable project structure

---
Terraform

├── VPC
│   ├── Public Subnets
│   ├── Private App Subnets
│   └── Private DB Subnets
│
├── Internet Gateway
├── NAT Gateway
├── Route Tables
│
├── Security Groups
│
├── EC2
│   └── Dockerized App
│
├── Application Load Balancer
│
├── Auto Scaling Group
│
├── RDS PostgreSQL
│
├── S3 Bucket
│
├── CloudWatch
│
└── IAM Roles

---

## 🏗️ Architecture Overview

```text
                              Internet
                                  │
                          Internet Gateway
                                  │
                     Application Load Balancer
                                  │
                        Auto Scaling Group
                                  │
                    EC2 Application Instances
                                  │
                    Private Application Subnets
                                  │
                          PostgreSQL (RDS)
                                  │
                    Private Database Subnets

        ┌──────────────────────────────────────────┐
        │                  VPC                     │
        │                                          │
        │  Public Subnets                          │
        │  Private Application Subnets             │
        │  Private Database Subnets                │
        └──────────────────────────────────────────┘

          S3 Remote Backend • CloudWatch • IAM
```

---

## 🚀 Infrastructure Components

### Networking

- Custom VPC
- Public Subnets
- Private Application Subnets
- Private Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Route Table Associations

### Compute

- Launch Template
- EC2 Instances
- Auto Scaling Group
- User Data for Bootstrapping

### Load Balancing

- Application Load Balancer
- Target Groups
- Health Checks
- HTTP Listener

### Database

- Amazon RDS PostgreSQL
- DB Subnet Group
- Parameter Group

### Storage

- S3 Bucket
- Remote Terraform State
- State Versioning

### Security

- IAM Roles
- IAM Instance Profiles
- Security Groups
- Least Privilege Access

### Monitoring

- CloudWatch Log Groups
- CloudWatch Alarms
- EC2 Monitoring

---

## 📂 Project Structure

```text
terraform-aws-production-infra/

├── backend.tf
├── provider.tf
├── versions.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── terraform.tfvars

├── modules/
│   ├── vpc/
│   ├── subnet/
│   ├── security-group/
│   ├── alb/
│   ├── ec2/
│   ├── autoscaling/
│   ├── rds/
│   ├── iam/
│   ├── s3/
│   └── cloudwatch/

├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/

└── README.md
```

---

## 📚 Terraform Concepts Demonstrated

- Providers
- Variables
- Outputs
- Locals
- Modules
- Custom Modules
- Remote Backend
- State Locking
- Data Sources
- Resource Dependencies
- Expressions
- Dynamic Blocks
- Environment Separation
- Terraform Best Practices

---

## 🛠️ AWS Services Used

- Amazon VPC
- Amazon EC2
- Application Load Balancer
- Auto Scaling Group
- Amazon RDS
- Amazon S3
- Amazon CloudWatch
- AWS IAM
- Elastic IP
- NAT Gateway

---

## 🎯 Future Enhancements

- HTTPS with ACM
- Route53 Integration
- WAF Protection
- AWS Systems Manager (SSM)
- Bastion Host
- CI/CD with GitHub Actions
- Blue/Green Deployments
- Amazon EKS Deployment
- Monitoring Dashboard
- Cost Optimization

---

## 📖 Learning Outcomes

This project is designed to strengthen practical knowledge of:

- Infrastructure as Code (IaC)
- AWS Networking
- Modular Terraform Design
- Production Infrastructure Provisioning
- Infrastructure Automation
- High Availability Architecture
- Secure Cloud Infrastructure
- Terraform Project Organization

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome. Feel free to fork the repository, open issues, or submit pull requests.

---

## 📄 License

This project is licensed under the MIT License.