# Base image is the Ubuntu Focal from Docker Hub
FROM ubuntu:hirsute

LABEL maintainer="Bartosz Burda <Bartosz.Burda@umlaut.com>"

# Set the env variables
ENV CXX=/usr/bin/g++-10 \
    CC=/usr/bin/gcc-10 \
# This should be changed to your Timezone
    TZ=Europe/Warsaw

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add x86 support
RUN dpkg --add-architecture i386

# Install dependencies using apt
RUN DEBIAN_FRONTEND=noninteractive apt -qq update && \
       apt -qq install -y \
       sudo \
       wget \
       git \
       curl \
       gcc \
       g++ \
       cmake \
       ninja-build \
       pkg-config \
       gdb \
       clang-format \
       clang \
       python3 \
       python3-pip \
       python3-setuptools \
       python3-wheel \
       doxygen \
       graphviz \
       clang-tidy \ 
       locales

# Install Python packages: Meson, Conan, gcovr and Sphinx with traceability plugin
RUN pip3 install meson conan gcovr Sphinx sphinxcontrib-traceability

# Setup locales
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=en_US.UTF-8

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Create user for development
RUN useradd -m dev --uid=1000 && echo "dev:dev" | chpasswd

# Set login shell for dev to /bin/bash
RUN chsh -s /bin/bash dev

# Add user to sudo group
RUN sudo usermod -aG sudo dev

# Set user and work directory
USER dev
WORKDIR /home/dev
