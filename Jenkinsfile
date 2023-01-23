pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    node{
        stages {
            stage('Poll Code Repository') {
                steps {
                    git credentialsId: 'jnks-pvt', url: 'git@github.com:Naveen-100/terraform-project.git'
                }
            }
            stage('terraform format') {
                when {
                    expression {action == 'apply'}
                }
                steps {
                    script {
                            sh 'terraform fmt'
                    }
                }
            }
            stage('terraform initialize') {
                when {
                    expression {action == 'apply'}
                }
                steps{
                    script {
                            sh 'terraform init'
                    }
                }
            }
            stage('terraform validate') {
                when {
                    expression {action == 'apply'}
                }
                steps{
                    script {
                            sh 'terraform validate'
                    }
                }
            }
            stage('terraform plan') {
                when {
                    expression {action == 'apply'}
                }
                steps{
                    script {
                            sh 'terraform plan'
                            input "Deploy to prod?"
                    }
                }
            }
            stage('terraform apply') {
                when {
                    expression {action == 'apply'}
                }
                steps{
                    script {
                            sh 'terraform apply --auto-approve'
                        }
                    
                }
            }
            stage('Install helm') {
                when {
                    expression {action == 'apply'}
                }
                steps{
                    sh'''
                        export PUBLIC_IP=$(az vm show -d -g rg -n websubnet-web-vm --query publicIps -o tsv)
                        ssh -tt -o "StrictHostKeyChecking no" azureuser@$PUBLIC_IP <<EOT
                        whoami
                        sudo helm repo add bitnami https://charts.bitnami.com/bitnami
                        sudo helm install my-nginx-release bitnami/nginx
                        exit
                    '''
                }
            }
            stage("Install Istio"){
                when {
                    expression{action == "apply"}
                }
                steps{
                    sh '''
                        export PUBLIC_IP=$(az vm show -d -g rg -n websubnet-web-vm --query publicIps -o tsv)
                        ssh -tt -o "StrictHostKeyChecking no" azureuser@$PUBLIC_IP <<EOT
                        whoami
                        curl -L https://istio.io/downloadIstio | sh -
                        cd istio-1.16.1
                        export PATH=$PWD/bin:$PATH
                        sudo istioctl install --set profile=demo -y
                        sudo kubectl label namespace default istio-injection=enabled
                        sudo kubectl get deployment
                        sudo kubectl get svc
                        exit
                    '''
                }
            }
            stage('terraform destroy') {
                when {
                    expression {action == 'destroy'}
                }
                steps{
                    script {
                            sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}