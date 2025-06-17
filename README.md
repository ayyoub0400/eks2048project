# 🕹️ 2048 Game Deployment on AWS EKS (GitOps Pipeline)

This project demonstrates a full CI/CD pipeline for deploying a containerised 2048 game using **Kubernetes on AWS EKS**, managed with **GitOps via ArgoCD**, **Terraform** for infrastructure, and **GitHub Actions** for continuous integration.

---

## 🔧 Tech Stack

- **AWS EKS** – Kubernetes cluster hosting the application  
- **Terraform** – Infrastructure as Code for provisioning AWS resources  
- **ArgoCD** – GitOps continuous deployment tool  
- **Docker** – Containerisation of the 2048 game  
- **GitHub Actions** – CI pipeline to build and push Docker images  
- **Helm** – Kubernetes manifest templating and packaging  
- **ExternalDNS** – Automatic DNS record management  
- **ALB Ingress Controller** – Load balancing and HTTP routing  
- **GoDaddy DNS** – Domain provider used for ExternalDNS integration
