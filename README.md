# AWS RDS PostgreSQL Terraform Configuration

This repository contains Terraform configurations to deploy an AWS RDS PostgreSQL database instance with associated resources such as a security group and subnet group.

---

## 🗂 Repository Structure

- **`main.tf`**: Main Terraform configuration file defining resources such as the AWS provider, security group, RDS subnet group, and the RDS instance itself.
- **`variables.tf`**: Definitions of input variables, making the configuration flexible and reusable.
- **`.gitignore`**: Specifies files and directories to ignore in the repository, including sensitive information like `terraform.tfvars`.
- **`LICENSE`**: MIT License file.

---

## ⚙️ Features

1. **AWS Provider Configuration**
   - Supports custom AWS region and credentials via variables.

2. **Security Group**
   - Opens port `5432` for PostgreSQL access to all IPs (configurable).
   - Includes default egress rules for all outbound traffic.

3. **Dynamic Subnet Group**
   - Automatically fetches subnets based on the provided VPC ID.
   - Creates an RDS subnet group using dynamically fetched subnets.

4. **RDS Instance**
   - Deploys a PostgreSQL instance (`16.3` version) with configurable parameters.
   - Enables public accessibility and integrates with the created security and subnet groups.

---

## 📦 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (≥ 1.0.0)
- AWS CLI configured with proper credentials
- An existing VPC in the specified AWS region

---

## 🚀 Usage

### 1. Clone the Repository

```bash
git clone https://github.com/melisacar/terraform-rds.git
cd terraform-rds
```

### 2. Configure Variables

Create a `terraform.tfvars` file to define sensitive information and project-specific values:

```t
aws_access_key     = "your-access-key"
aws_secret_key     = "your-secret-key"
vpc_id             = "your-vpc-id"
db_username        = "your-db-username"
db_password        = "your-db-password"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan the Deployment

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply
```

### 6. Destroy Resources (When Needed)

```bash
terraform destroy
```

## 🛠️ Customization

You can customize the configuration by modifying the following variables in `variables.tf` or `terraform.tfvars`:

- `db_instance_class`: Change the RDS instance type (default: `db.t3.micro`).
- `db_allocated_storage`: Specify the storage size in GB (default: `20`).
- `aws_region`: Specify the AWS region (default: `eu-north-1`).

## 🔒 Security Notes

- Ensure sensitive information, such as `aws_access_key` and `aws_secret_key`, is excluded from the repository by adding them to `.gitignore` or using a secrets management tool.
- Consider restricting the IP range in the security group (`cidr_blocks`) to trusted IPs only.

## 📝 License

This project is licensed under the MIT License.
