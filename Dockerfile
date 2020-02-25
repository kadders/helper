FROM ubuntu:18.04

# Baseline package install
RUN apt-get update; apt-get install virtualenv libdbus-glib-1-dev build-essential python python3 python3-venv groff vim python3-pip python-pip curl unzip wget pkg-config packer apt-transport-https ca-certificates curl gnupg-agent software-properties-common xclip xsel jq dnsutils -y

# Install docker things
# Add GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Add in repo
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list;
# update and pull docker, git-crypt kubectl
RUN apt-get update; apt-get install docker-ce docker-ce-cli containerd.io docker-compose git-crypt kubectl -y

# Set to python3 by default in system
# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
RUN pip install aws-okta-keyman

# Installer for AWSCLIv2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; unzip awscliv2.zip; ./aws/install

### Versions for packages ###
# Set TF Version
ENV tf_ver="0.11.15-oci"
# Set Packer version
ENV packer_ver="1.5.4"
### End Versions Block ###

# Pull down packer
RUN wget https://releases.hashicorp.com/packer/${packer_ver}/packer_${packer_ver}_linux_amd64.zip; unzip packer*.zip; mv packer /usr/bin
# Install TF
RUN wget https://releases.hashicorp.com/terraform/${tf_ver}/terraform_${tf_ver}_linux_amd64.zip; unzip terraform*.zip; mv terraform /usr/bin

# Create add-ons dir for things
RUN mkdir -p /usr/local/add-ons/
# Pull down kube ps1 things
RUN git clone https://github.com/jonmosco/kube-ps1.git /usr/local/add-ons/kube-ps1
RUN git clone https://github.com/git/git.git /usr/local/add-ons/git-core; cp /usr/local/add-ons/git-core/contrib/completion/git-prompt.sh /usr/local/add-ons/git-prompt.sh
# Also get the aws-iam-authenticator
RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator; chmod +x /usr/local/bin/aws-iam-authenticator

COPY bash_profile /usr/local/add-ons/bash_profile

# get the command-line up and running
CMD ["/bin/bash"]