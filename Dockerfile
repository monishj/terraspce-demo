FROM boltops/terraspace:centos

RUN yum update -y
#RUN  yum -y install dpkg-devel dpkg-dev
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.58.0/opa_linux_arm64_static && chmod 755 ./opa && mv ./opa /usr/local/bin/

RUN  yum clean all &&  rm -rf /var/cache/yum


