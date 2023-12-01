FROM centos:8
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y
RUN yum install -y yum-utils
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo \ && \
    yum install -y terraform epel-release ruby

RUN  yum -y install dpkg unzip
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.58.0/opa_linux_arm64_static && chmod 755 ./opa && mv ./opa /usr/local/bin/

RUN curl -so /etc/yum.repos.d/boltops.repo https://yum.boltops.com/boltops.repo
RUN rpm --import https://yum.boltops.com/boltops-key.public
RUN yum install -y terraspace make libffi-devel libtool

RUN yum install -y curl openssl && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    sh get_helm.sh && \
    echo "Helm installed"

RUN curl -LO https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN  yum clean all &&  rm -rf /var/cache/yum