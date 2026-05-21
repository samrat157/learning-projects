## To install or setup Jenkins on local

Assumptions - 
1. Kubernetes cluster is already setup
2. Docker is already installed
3. Helm is installed

``` 
Steps to create Jenkins Docker Image

docker build -f jenkins/docker/jenkins.dockerfile -t jenkins:v1 jenkins/docker

Steps to setup jenkins using Kubernetes
1. kubectl create ns jenkins
2. kubectl apply -f cluster_role.yaml
3. kubectl apply -f service_account.yaml
4. kubectl apply -f cluster_role_binding.yaml
5. kubectl apply -f deployment.yaml
6. kubectl apply -f service.yaml

You can test out the same once the service is up and configured using port-forward
- kubectl port-forward svc/jenkins-service 8080:8080

Once you can see the following service up and running on your browser, it means the Jenkins has been setup

Now we need to use ingress to expose it on our local

1. We need to install an ingress controller
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm repo list
    helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace ingress-nginx

2. Once the Ingress Controller is installed, check if the services in your ingress controller are having an IP associated, if not perform the following

    helm upgrade ingress-nginx ingress-nginx/ingress-nginx   --namespace ingress-nginx   --reuse-values   --set controller.publishService.enabled=true
    helm upgrade ingress-nginx ingress-nginx/ingress-nginx   --namespace ingress-nginx   --reuse-values   --set controller.service.ports.http=8080

3. Once setup, we can apply the ingress yaml manifest

    kubectl apply -f ingress.yaml
```
