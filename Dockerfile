FROM ubuntu:18.04

# Baseline package install
RUN apt-get update; apt-get install python python3 python3-venv python3-pip python-pip curl unzip wget packer apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

# Install docker things
# Add GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Add in repo
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# update and pull docker
RUN apt-get update; apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

# Set to python3 by default in system
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
# RUN pip install dbus-python aws-okta-keyman

# Installing git-crypt
RUN apt-get install git-crypt -y

# Installer for AWSCLIv2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; unzip awscliv2.zip; ./aws/install

# Pull down packer
RUN wget https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip; unzip packer*.zip; mv packer /usr/bin

# Installing Kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list; apt-get update; apt-get install -y kubectl

# get the command-line up and running
CMD ["/bin/bash"]