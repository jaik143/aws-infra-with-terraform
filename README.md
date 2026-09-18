# Highly Available AWS Infrastructure with Terraform

Multi-AZ AWS environment provisioned entirely as code — an Nginx reverse-proxy tier fronting Apache backends, split across two availability zones behind external and internal load balancers.

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonwebservices&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx&logoColor=white)

---

## Architecture

Traffic enters through an internet-facing Application Load Balancer, reaches an Nginx reverse-proxy tier in the public subnets, and is forwarded to an internal ALB in front of Apache backends running in the private subnets. Every tier is duplicated across two availability zones.

```
                        Internet
                            |
                   +--------v--------+
                   |  External ALB   |
                   +--------+--------+
          +-----------------+-----------------+
     AZ-a |                                   | AZ-b
  +-------v--------+                 +--------v-------+
  | Public subnet  |                 | Public subnet  |
  |  Nginx proxy   |                 |  Nginx proxy   |
  |  NAT Gateway   |                 |  NAT Gateway   |
  +-------+--------+                 +--------+-------+
          +-----------------+-----------------+
                   +--------v--------+
                   |  Internal ALB   |
                   +--------+--------+
          +-----------------+-----------------+
  +-------v--------+                 +--------v-------+
  | Private subnet |                 | Private subnet |
  | Apache backend |                 | Apache backend |
  +----------------+                 +----------------+
```

## What this provisions

| Component | Count | Notes |
|---|---|---|
| VPC | 1 | Custom CIDR, DNS hostnames enabled |
| Internet Gateway | 1 | Public ingress and egress |
| Subnets | 4 | 2 public, 2 private — one pair per AZ |
| NAT Gateways | 2 | One per AZ, so a single-AZ failure does not cut egress for the other |
| Route tables | 3 | One public, one private per AZ |
| Application Load Balancers | 2 | External (edge) and internal (backend tier) |
| Security groups | 1 | HTTP/SSH, referenced rather than CIDR-matched |
| EC2 instances | 4 | 2x Nginx proxy (public), 2x Apache backend (private) |

## Engineering decisions

**One NAT Gateway per availability zone.** A single shared NAT Gateway is cheaper but creates a cross-AZ dependency — if its AZ fails, instances in the surviving AZ lose outbound internet. Each AZ gets its own.

**Backends are never publicly routable.** The Apache tier sits in private subnets with no public IPs. It is reachable only through the internal ALB, which is itself only reachable from the Nginx tier's security group.

**Remote state with locking.** State lives in S3 with a DynamoDB lock table (`backend.tf`), so two people running `terraform apply` at the same time cannot corrupt it.

**Configuration is generated, not hand-edited.** The Nginx config (`nginx.tpl`) and EC2 user data (`nginx.sh`, `apache1.sh`, `apache2.sh`) are rendered through `templatefile()`, so upstream addresses come from Terraform outputs instead of being pasted in after deployment.

**Composed from modules.** Networking, compute, load balancing and security live as separate modules under `Modules/` rather than in one flat file, so each layer can be changed and reused independently.

## Repository layout

```
.
├── Modules/            # vpc, subnet, routetable, nat, securitygroup, loadbalancer, ec2
├── images/             # architecture diagram and deployment screenshots
├── main.tf             # root module - wires the modules together
├── provider.tf         # AWS provider and region
├── backend.tf          # S3 remote state + DynamoDB state locking
├── outputs.tf          # exported IDs and load balancer DNS names
├── nginx.tpl           # templated Nginx reverse-proxy configuration
├── nginx.sh            # Nginx instance user data
└── apache1.sh / apache2.sh   # Apache backend user data
```

## Prerequisites

- Terraform >= 1.5
- AWS CLI v2, configured with credentials that can create VPC, EC2, ELB, S3 and DynamoDB resources
- An S3 bucket and DynamoDB table for remote state (see `backend.tf`)

## Deploy

```bash
git clone https://github.com/jaik143/aws-infra-with-terraform.git
cd aws-infra-with-terraform

terraform init      # configures the S3 backend
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Exported values — including the load balancer DNS names — are defined in `outputs.tf`:

```bash
terraform output
```

## Tear down

```bash
terraform destroy
```

State and the lock table survive `destroy` and must be removed separately if no longer needed.

## Notes

The S3 bucket and DynamoDB table names in `backend.tf` are environment-specific — change them to your own before running `terraform init`. Backend blocks cannot use variables, so these are edited directly or supplied with `-backend-config`.

---

**Author** — Kadali Jayanth Kumar · [LinkedIn](https://linkedin.com/in/jayanth-kadali-419798182)
