FROM --platform=linux/amd64 ubuntu:22.04

#https://wiki.ubuntu.com/Releases

ENV DEBIAN_FRONTEND=noninteractive

# Try any of these maybe?
    # libc6-dev \
    # linux-libc-dev \
    # build-essential

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    git \
    gdb \
    wget \
    patchelf \
    file \
    strace \
    tmux \
    python3 \
    nasm \
    binwalk \
    bsdmainutils \
    netcat \
    python3-pip \
    ruby-full \
    valgrind \
    vim \
    xclip \
    elfutils \
    checksec \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/pwndbg/pwndbg
WORKDIR /opt/pwndbg
ENV LC_ALL=C.UTF-8
RUN ./setup.sh

WORKDIR /opt
RUN wget https://github.com/io12/pwninit/releases/download/3.3.0/pwninit && \
    chmod +x pwninit

RUN gem install one_gadget
RUN pip3 install IPython icecream angr pwntools

WORKDIR /home/localdir
CMD ["bash"]
