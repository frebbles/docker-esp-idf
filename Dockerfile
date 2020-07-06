FROM ubuntu:18.04
LABEL maintainer="https://github.com/frebbles"

ARG USERID=500
ARG GROUPID=1000

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
        apt-get -y update && \
        apt-get -y upgrade && \
        apt-get install --no-install-recommends -y \
        gnupg \
	bash \
        build-essential \
        ca-certificates \
        dos2unix \
	sudo \
	openssh-server \
        make \
        git \
	vim

RUN apt-get install --no-install-recommends -y git wget flex bison gperf python python-pip python-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util

RUN apt-get install --no-install-recommends -y python3 python3-pip python3-setuptools

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Create a user
RUN groupadd -g $GROUPID -o user
RUN useradd -u $USERID -m -g user -G plugdev,dialout user \ 
        && echo 'user ALL = NOPASSWD: ALL' > /etc/sudoers.d/user \
        && chmod 0440 /etc/sudoers.d/user

RUN mkdir /workdir && \
    chown user:user /workdir

USER user

RUN mkdir -p /home/user/esp && \
    cd /home/user/esp && \
    git clone --recursive https://github.com/espressif/esp-idf.git

RUN cd /home/user/esp && \
    git clone --recursive https://github.com/espressif/esp-adf.git

RUN cd /home/user/esp && \
    git clone --recursive https://github.com/espressif/esp-who.git

RUN cd /home/user/esp/esp-idf && \
    ./install.sh

CMD export IDF_PATH=/home/user/esp/esp-idf && \
    export ADF_PATH=/home/user/esp/esp-adf && \
    . /home/user/esp/esp-idf/export.sh && \
    /bin/bash

