FROM ubuntu:18.04

RUN apt-get update; apt-get install python python3 python3-venv python3-pip python-pip curl unzip -y
# Set to python3 by default in system
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
# RUN pip3 install awscli
# RUN pip install dbus-python aws-okta-keyman

# Installing git-crypt
RUN apt-get install git-crypt -y

# Installer for AWSCLIv2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; unzip awscliv2.zip; ./aws/install

# symlink the configs from the end-user
# COPY /Users/kyle.adams/.gitconfig /root/.gitconfig

# get the command-line up and running
CMD ["/bin/bash"]