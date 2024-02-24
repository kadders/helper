FROM ubuntu:22.04

# Baseline package install
RUN apt-get update; apt-get install git libdbus-glib-1-dev build-essential python3 python3-venv groff vim python3-pip curl unzip zip wget pkg-config packer apt-transport-https ca-certificates  gnupg-agent software-properties-common xclip xsel jq dnsutils bsdmainutils man-db nodejs golang sqlite3 -y

# Install docker things
# Get kubectl keyring
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# Install 1.29 packages
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
# Update and install
RUN apt-get update
RUN apt-get install -y kubectl

# Add in some python3 libraries for fun
RUN pip3 install boto3 numpy requests

# Create add-ons dir for things
RUN mkdir -p /usr/local/add-ons/
# Pull down kube ps1 things
RUN git clone https://github.com/jonmosco/kube-ps1.git /usr/local/add-ons/kube-ps1
# RUN git clone https://github.com/git/git.git /usr/local/add-ons/git-core; cp /usr/local/add-ons/git-core/contrib/completion/git-prompt.sh /usr/local/add-ons/git-prompt.sh
RUN wget https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh -O /usr/local/add-ons/git-prompt.sh
RUN wget https://github.com/git/git/blob/master/contrib/completion/git-completion.bash -O /usr/local/add-ons/git-completion.bash

# Add in pytorch for cpu
# RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

COPY bash_profile /usr/local/add-ons/bash_profile

# get the command-line up and running
CMD ["/bin/bash"]