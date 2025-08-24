# 🚀 Terraform-AWS-NTI Project

---

## 📋 **Overview**

This project automates the deployment of a **secure** and **scalable** cloud infrastructure on **AWS** using **Terraform**. The setup includes key AWS components to ensure high availability, security, and efficiency:

- **VPC** with public and private subnets  
- **EC2 instances** for app servers  
- **NAT Gateway** for secure internet access  
- **Nginx reverse proxy** for traffic routing  
- **Load Balancer** for fault tolerance  
- **S3 & DynamoDB** for Terraform state management  


---

## 🏗️ **Architecture Diagram**

![Image](https://github.com/user-attachments/assets/43abfc17-d0fe-4f4f-9ca9-3fc95a95b562)

> The diagram shows a **VPC** with two Load Balancers distributing internet traffic efficiently using **Nginx** as a reverse proxy and backend web servers across multiple **Availability Zones (AZs)**.

---

## 🧩 **Architecture Components**

| Component                    | Description                                                            |
|------------------------------|------------------------------------------------------------------------|
| **VPC**                      | Isolated AWS network environment.                                      |
| **Internet Gateway (IGW)**   | Connects VPC to the internet; enables public subnet connectivity.      |
| **Public Subnets**           | Host internet-facing resources (e.g., Bastion Host).                   |
| **Private Subnets**          | Host internal resources like application servers.                      |
| **Route Tables**             | Routes traffic appropriately (public → IGW, private → NAT Gateway).    |
| **NAT Gateway**              | Allows private subnet instances outbound internet access securely.     | 
| **Elastic IP**               | Static IP assigned to NAT Gateway for stable connectivity.             |
| **Security Groups**          | Virtual firewalls controlling inbound/outbound traffic.                |
| **Nginx Instances**          | Reverse proxy servers located in public subnets.                       |
| **Apache Backend Instances** | Web servers located in private subnets.                                |
| **Load Balancer**            | Distributes incoming traffic for fault tolerance and high availability.|

---

## 🛠️ **Getting Started**

1. **Install Terraform:**  
   Download from the [official Terraform website](https://www.terraform.io/downloads).

2. **Configure AWS Credentials:**  
   Setup AWS CLI credentials on your machine (`aws configure`).

3. **Initialize Terraform:**
   - Run `terraform init` to initialize the project.

4. **Plan the Deployment:**
   - Execute `terraform plan` to preview the infrastructure changes.

5. **Apply the Deployment:**
   - Run `terraform apply` to create the infrastructure on AWS.

## Screen Shots
- **Main VPC**
![Image](https://github.com/user-attachments/assets/b77c793c-8a68-4744-b5cd-39641ae7d355)
- **External Load Balancer**
![Image](https://github.com/user-attachments/assets/87beb548-a545-4a63-b7b1-217f5cfd6525)
- **Internal Load Balancer**
![Image](https://github.com/user-attachments/assets/99d0b47c-63a4-4d2d-9aa1-2fd20d72261b)
- **S3 Bucket (Terraform State Storage)**
![Image](https://github.com/user-attachments/assets/1f2b7e05-62fb-4ebe-b8d2-76452a3ecc63)
- **EC2 Instances**
![Image](https://github.com/user-attachments/assets/28535fc0-ca38-4ef4-a42d-36b48d3ac496)
- **Testing with External Load Balancer DNS**
![Image](https://github.com/user-attachments/assets/bd6530f5-7d80-4027-9048-24e70565a3e2)  ![Image](https://github.com/user-attachments/assets/4d6eefae-511e-4cb8-bbca-5f754bc8831e)


---

## 👨‍💻 Author  
Kadali Jayanth Kumar 
🎓 jayanthkumarkadali25@gmail.com   
🔗 [(https://www.linkedin.com/in/jayanth-kadali-419798182)]

---

