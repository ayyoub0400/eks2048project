# 2048 on AWS EKS with Terraform and ArgoCD

An independent learning project focused on AWS infrastructure, Kubernetes deployment and GitOps. The game uses an existing public container image; my contribution is the infrastructure and deployment setup, not the game itself.

**Status:** historical portfolio deployment, no longer running. The checked-in configuration needs review before redeployment; it is not a production-ready, one-command installation.

## What this repository demonstrates

- VPC and EKS provisioning through the community Terraform AWS modules.
- Private worker-node subnets, public load-balancer subnets and a single NAT gateway.
- S3 Terraform remote state with lock-file configuration.
- An ArgoCD Application with automated sync, pruning and self-healing.
- A two-replica 2048 Deployment plus separate Service and ALB HTTPS ingress manifests.
- ACM certificate and ExternalDNS hostname annotations.

During the original deployment I installed ArgoCD using Helm, configured HTTPS ingress and investigated CrashLoopBackOff failures through log inspection. Those operational steps are not all captured as automation here.

## Start with these files

| Path | Purpose |
| --- | --- |
| [terraform/main.tf](terraform/main.tf) | VPC and EKS modules, node-group configuration |
| [terraform/terraform.tf](terraform/terraform.tf) | Provider constraints and S3 backend |
| [k8s/](k8s/) | Namespace and application Deployment |
| [yaml/app.yaml](yaml/app.yaml) | ArgoCD Application tracking the `k8s` directory |
| [yaml/Service.yaml](yaml/Service.yaml) | Application Service |
| [yaml/Ingress.yaml](yaml/Ingress.yaml) | Application HTTPS ingress |
| [yaml/ArgoCDingress.yaml](yaml/ArgoCDingress.yaml) | ArgoCD ingress |

ArgoCD currently reconciles **only `k8s/`**. The Service and ingress manifests in `yaml/` are outside that path and need separate management.

## Reproduction prerequisites and gaps

1. Use an AWS sandbox account, Terraform, AWS CLI, kubectl and Helm. Authenticate without committing credentials.
2. Replace the backend bucket, certificate ARN, hostnames and environment-specific values with resources you own. Bootstrap the state bucket separately and protect its contents.
3. Reconcile Terraform/backend compatibility: the repository permits Terraform 1.3-era versions but configures S3 `use_lockfile`; select a version supporting this feature before initialisation.
4. Review the pinned EKS 1.29, node AMI and module/provider versions against current AWS support before planning.
5. Review public cluster-endpoint access and the single-NAT availability/cost trade-off.
6. Install and configure ArgoCD, AWS Load Balancer Controller and ExternalDNS with suitable IAM permissions. Controller installation is not automated in this repository.
7. Decide whether to move all application resources under GitOps management or manage the Service and ingresses separately.
8. Review a Terraform plan before applying any infrastructure changes. Verify ArgoCD sync, pods, Service endpoints and HTTPS routing afterwards.

No GitHub Actions workflow or Dockerfile is committed here, so this repository demonstrates infrastructure and GitOps deployment rather than a complete image-build CI pipeline. The app image uses `latest`; immutable image versions, probes and resource limits are future improvements.

## Cost and teardown

EKS, worker nodes, NAT and load balancers incur costs while running. Check current regional pricing and set a budget before redeploying. Remove Kubernetes ingress/load-balancer resources and confirm their AWS cleanup before reviewing a Terraform destroy plan. Keep the state backend until resource cleanup is verified. Destruction is only for a disposable environment you own.

## Historical screenshots

These are evidence from the earlier deployment, not a live-service guarantee.

![Historical deployment screenshot](https://github.com/user-attachments/assets/affa2749-a8c2-41bc-9c5c-77a5313e2b62)
![Historical deployment screenshot](https://github.com/user-attachments/assets/321772bc-11bb-4827-954c-47568445a6b6)
