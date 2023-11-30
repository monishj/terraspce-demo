FROM centos:7
RUN  yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum update -y \ && \
     yum install -y install terraform epel-release ruby
RUN  yum -y install dpkg-devel dpkg-dev unzip
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.58.0/opa_linux_arm64_static && chmod 755 ./opa && mv ./opa /usr/local/bin/
RUN  yum clean all &&  rm -rf /var/cache/yum