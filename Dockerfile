ARG CUDA_VERSION=10.0
ARG PYTHON_VERSION=3.6
FROM nvidia/cuda:${CUDA_VERSION}-cudnn7-runtime-ubuntu18.04

# install the stuff you'd expect to have + ssh server
RUN apt-get update
RUN apt-get -y install software-properties-common sudo fuse curl git zip libsm6 libxext6 libxrender-dev openssh-server

# install python and pip
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt -y install python${PYTHON_VERSION} python3-pip

# install gscfuse for mounting buckets
RUN curl -L -O https://github.com/GoogleCloudPlatform/gcsfuse/releases/download/v0.27.0/gcsfuse_0.27.0_amd64.deb
RUN dpkg --install gcsfuse_0.27.0_amd64.deb

# install a very very insecure ssh server :p
RUN mkdir /var/run/sshd
RUN echo root:pass | chpasswd
RUN sed -i '1s/^/PermitRootLogin prohibit-password\n/' /etc/ssh/sshd_config
RUN sed -i '1s/^/PermitRootLogin yes\n/' /etc/ssh/sshd_config
RUN sed -i '1s/^/PermitEmptyPasswords yes\n/' /etc/ssh/sshd_config
# fixes issues with connecting to ftp
RUN sed -i 's+/usr/lib/openssh/sftp-server+internal-sftp+g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]