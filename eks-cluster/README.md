# wymm-terraform-labs
## Terraform Labs
## Infra Diagram
![eks-cluster](https://github.com/WaiYanMyintMyat/wymm-terraform-labs/blob/main/eks-cluster/eks-cluster.png)

## Setup
To run this project
```
terraform init
terraform plan
terraform apply
```

## Destory
To destory infra
```
terraform destory
```

## After set up eks cluster
```
* Install and Configure AWS CLI
  - aws configure
  - Follow the prompts to input your AWS Access Key ID, Secret Access Key, region, and output format.
* Configure kubectl to use the EKS cluster
  -  aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
* Verify Configuration
  - kubectl config current-context
* Access the Cluster:
  - kubectl get nodes
```

## Installation Metrics Server
```
* Apply for metrics server
  - kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
* Verify Metrics Server Logs
  - kubectl logs -n kube-system $(kubectl get pods -n kube-system -l k8s-app=metrics-server -o name) 
* Check Metrics API Availability
  - kubectl top nodes
```

## Check connectivity between nodes
```
If connectivity between nodes is not have, you should check inbound rules of security groups.
```

Thank you 🤗🤗🥳🥳