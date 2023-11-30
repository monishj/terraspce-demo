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

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.58.0/opa_linux_arm64_static && chmod 755 ./opa && mv ./opa /usr/local/bin/

RUN curl -so /etc/yum.repos.d/boltops.repo https://yum.boltops.com/boltops.repo
RUN rpm --import https://yum.boltops.com/boltops-key.public
RUN yum install -y terraspace


RUN  yum clean all &&  rm -rf /var/cache/yum