# 2-Tier AWS Architecture with Terraform - #12WeeksAWSWorkshopChallenge

This repository provides Terraform configurations to deploy a robust 2-tier architecture on Amazon Web Services (AWS). This is an advanced level of Workshop designed by AWS for AWS Immersion Day Workshops. More details are here: [AWS Immersion Day Workshops](https://catalog.workshops.aws/general-immersionday/en-US/).


The architecture is designed for high availability, scalability, and security. It includes Virtual Private Cloud (VPC) setup, public and private subnets in multiple availability zones, NAT Gateway, Internet Gateway, Auto Scaling Group, Application Load Balancer, and a Multi-AZ RDS cluster with MySQL database. The setup is modularized for easy management and customization.

## Table of Contents

- [2-Tier AWS Architecture with Terraform - #12WeeksAWSWorkshopChallenge](#2-tier-aws-architecture-with-terraform---12weeksawsworkshopchallenge)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Architecture Overview](#architecture-overview)
  - [Getting Started](#getting-started)
    - [1. Clone the Repository](#1-clone-the-repository)
    - [2. Update Configuration](#2-update-configuration)
    - [3. Secrets Manager Configuration](#3-secrets-manager-configuration)
    - [3. Create AWS Resources](#3-create-aws-resources)
  - [AWS Resources in AWS Management Console](#aws-resources-in-aws-management-console)
  - [Security Configuration](#security-configuration)
  - [Destroy AWS Resources](#destroy-aws-resources)
  - [Contributing](#contributing)
  - [License](#license)

## Prerequisites

Before you start, ensure you have the following installed/configured:

- [Terraform](https://www.terraform.io/) installed locally.
- AWS credentials configured with appropriate permissions.
- An SSH key pair for secure access to instances.

## Architecture Overview

The architecture includes the following components:

- **VPC**: A Virtual Private Cloud in `us-east-1` region.
- **Subnets**: Public and private subnets in `us-east-1a` and `us-east-1b` availability zones.
- **NAT Gateway**: Provides internet access for instances in private subnets.
- **Internet Gateway**: Allows communication between the VPC and the internet.
- **Auto Scaling Group**: Manages EC2 instances running in private subnets.
- **Application Load Balancer**: Public-facing, distributing traffic to EC2 instances.
- **RDS Cluster**: Multi-AZ deployment with MySQL database for high availability.
- **Secrets Manager**: Securely stores sensitive information such as database credentials.

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/hsiddhu2/12_Weeks_AWS_WorkShop_Challenge.git
cd Week1/root
```

**Directory Structure: **
├── Address Book
│   ├── modules
│   │   ├── alb
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   ├── asg
│   │   │   ├── config.sh
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   ├── key
│   │   │   ├── main.tf
│   │   │   └── output.tf
│   │   ├── nat
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   ├── rds
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   ├── secrets
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   ├── security-group
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── output.tf
│   │       └── variables.tf
│   └── root
│       ├── backend.tf
│       ├── main.tf
│       ├── providers.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── README.md

### 2. Update Configuration

- Update `terraform.tfvars` in the `root/` with necessary variables.

Here is the example with the values:

region = "us-east-1"
project_name = "Immersionday"
vpc_cidr                = "10.1.0.0/16"
pub_sub_1a_cidr        = "10.1.1.0/24"
pub_sub_2b_cidr        = "10.1.2.0/24"
pri_sub_3a_cidr        = "10.1.11.0/24"
pri_sub_4b_cidr        = "10.1.12.0/24"
pri_sub_5a_cidr        = "10.1.21.0/24"
pri_sub_6b_cidr        = "10.1.22.0/24"
db_username = "awsuser"
db_password = "awspassword"
db_name = "immersionday"


- Generate an SSH key pair and place it in the `/modules/key/` directory for secure access to instances.
- cd into the `Week1/modules/key/` directory and run the following command:`ssh-keygen -f webappserver_key`

### 3. Secrets Manager Configuration
IMPORTANT: The address book application that will deployed using `modules/asg/config.sh`, will use the AWS Secret with name `mysecret` so keep in mind that you don't change that. For more information about the application, please visit [Address Book Application](https://static.us-east-1.prod.workshops.aws/public/444df362-a211-4686-869b-77496f0dd3be/assets/immersion-day-app-php7.zip').

### 3. Create AWS Resources

Go to /root directory and run the following commands:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

After successful deployment, check the Load Balancer DNS in the AWS Management Console to access your application.

## AWS Resources in AWS Management Console

- **VPC**: A secure network environment to launch AWS resources.
- **Subnets**: Divided into public and private subnets across multiple availability zones.
- **NAT Gateway**: Allows instances in private subnets to access the internet for updates and patches.
- **Internet Gateway**: Facilitates communication between the VPC and the internet.
- **Auto Scaling Group**: Ensures the desired number of EC2 instances are running for high availability and fault tolerance.
- **Application Load Balancer**: Distributes incoming traffic across EC2 instances in private subnets.
- **RDS Cluster**: Multi-AZ deployment ensures database availability and fault tolerance.
- **Secrets Manager**: Secure storage for sensitive information like database credentials.

## Security Configuration

- **Security Groups**: Configured to allow necessary inbound/outbound traffic flows for each component.
- **Secrets Management**: Sensitive information stored securely in AWS Secrets Manager for enhanced security.


## Destroy AWS Resources

To destroy all AWS resources created by Terraform, run the following command from the `/root` directory:

```bash
terraform destroy
```

## Contributing

Contributions are welcome! Please create an issue or pull request for any improvements or features you'd like to add.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Thanks,

