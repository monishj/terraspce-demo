properties([parameters([choice(choices: ['eks','rds','vpc','s3','ec2'], name: 'Module_NAME'), choice(choices: ['dev','test','prod'], name: 'ENVIRONMENT'), choice(choices: ['plan', 'apply', 'destroy'], name: 'Terraform_Action')])])
pipeline {
    agent {
        kubernetes {
            inheritFrom 'terraform'
        }
    }
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('SCM checkout') {
            steps {
                checkout scm
            }
        }
        stage('Init') {
                    steps {
                        container('golden-build-image') {
                        echo "Enter File Name ${params.Module_NAME}"
                        echo "Pipeline Name ${params.Pipeline}"
                        withAWS(credentials: 'aws', region: 'ap-south-1') {
                        sh 'terraform -chdir=environments/${ENVIRONMENT}/${Module_NAME} init --lock=false'
                        }
                        }
                    }
                }

        stage('Code Analysis') {
                    when {
                        expression { params.Terraform_Action != 'destroy'}
                    }
                    steps {
                    container('golden-build-image') {
                    sh '''
                       tflint --chdir modules/${Module_NAME}
                       tfsec modules/${Module_NAME} -m MEDIUM
                    '''
                    }
                    }
                }

        stage('Terratest') {
                            when { changeset "modules/${params.Module_NAME}/*" }
                            steps {
                            container('golang') {
                            withAWS(credentials: 'aws', region: 'ap-south-1') {
                            sh '''#!/bin/bash
                              cd modules/${Module_NAME}/test/
                              go mod download
                              go test -v -timeout 40m *.go
                            '''
                            }
                            }
                            }
                        }

        stage('Action') {
            steps {
            container('golden-build-image'){
                echo "${params.Terraform_Action}"
                withAWS(credentials: 'aws', region: 'ap-south-1') {
                sh 'terraform get -update'
                    script {
                        if (params.Terraform_Action == 'plan') {
                            sh 'terraform -chdir=environments/${ENVIRONMENT}/${Module_NAME} plan --lock=false'
                        }   else if (params.Terraform_Action == 'apply') {
                            sh 'terraform -chdir=environments/${ENVIRONMENT}/${Module_NAME} apply --lock=false -auto-approve'
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh 'terraform -chdir=environments/${ENVIRONMENT}/${Module_NAME} destroy --lock=false -auto-approve'
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
            }
            }
        }
    }
}