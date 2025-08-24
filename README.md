# 🚀 Terraform-Aws Infra Project

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
![Alt text](images/vpc.png)

- **Load Balancer (Internal and External)**
![Alt text](images/loadbalancers.png)

- **S3 Bucket (Terraform State Storage)**
![Alt text](images/s3.png)

- **EC2 Instances**
![Alt text](images/ec2.png)

- **DyanamoDb (Terraform State lock)**
![Alt text](images/dyanamodb-lock.png)


- **Testing with External Load Balancer DNS**
![Alt text](images/elb-test.png)


---

## 👨‍💻 Author  
Kadali Jayanth Kumar 
🎓 jayanthkumarkadali25@gmail.com   
🔗 [(https://www.linkedin.com/in/jayanth-kadali-419798182)]

---

