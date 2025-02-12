FROM ubuntu:24.04

# Baseline package install
RUN apt update; apt install vim groff curl ca-certificates xclip xsel jq golang zip wget pkg-config apt-transport-https gnupg-agent virtualenv python3-pip python3-venv git bsdmainutils man nodejs cmake software-properties-common libdbus-glib-1-dev build-essential man-db sqlite3 python3-boto3 python3-numpy python3-requests -y

# Install docker things
# Get kubectl keyring
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# Install 1.29 packages
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
# Update and install
RUN apt-get update
RUN apt-get install -y kubectl

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

RUN mkdir -p /tools

# get the command-line up and running
CMD ["/bin/bash"]
