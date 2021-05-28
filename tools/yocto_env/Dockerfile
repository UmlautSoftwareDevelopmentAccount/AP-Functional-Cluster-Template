# Base image is the Ubuntu Focal from Docker Hub
FROM bburda/autosar-adaptive-platform-dev-env

LABEL maintainer="Bartosz Burda <Bartosz.Burda@umlaut.com>"

USER root

# install Yocto pkgs
RUN apt -qq install -y \
       gawk \
       git-core \
       diffstat \
       unzip \
       texinfo \
       gcc-multilib \
       build-essential \
       chrpath \
       socat \
       cpio \
       python3-pexpect \
       xz-utils \
       debianutils \
       iputils-ping \
       python3-git \
       python3-jinja2 \
       libegl1-mesa \
       libsdl1.2-dev \
       pylint3 \
       xterm \
       locales

USER dev
WORKDIR /home/dev