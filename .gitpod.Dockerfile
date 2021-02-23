FROM ubuntu:18.04

ARG ZSDK_VERSION=0.11.2
ARG CMAKE_VERSION=3.16.2
ARG RENODE_VERSION=1.8.2
ARG DTS_VERSION=1.4.7

ARG UID=10000
ARG GID=10000

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
        apt-get -y update && \
        apt-get install --no-install-recommends -y \
        pkg-config \
        gnupg \
        ca-certificates && \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
        echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
        apt-get -y update && \
        apt-get install --no-install-recommends -y \
        autoconf \
        automake \
        build-essential \
        ccache \
        device-tree-compiler \
        dfu-util \
        dos2unix \
        doxygen \
        file \
        g++ \
        gcc \
        gcc-multilib \
        gcovr \
        git \
        git-core \
        gperf \
        gtk-sharp2 \
        iproute2 \
        lcov \
        libglib2.0-dev \
        libgtk2.0-0 \
        libpcap-dev \
        libsdl2-dev:i386 \
        libtool \
        locales \
        make \
        mono-complete \
        net-tools \
        ninja-build \
        openbox \
        python3-pip \
        python3-ply \
        python3-setuptools \
        python-xdg \
        #qemu \
        socat \
        sudo \
        texinfo \
        valgrind \
        wget \
        x11vnc \
        xvfb \
        xz-utils \
        autotools-dev \
        curl \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev \
        gawk \
        bison \
        flex \
        libtool \
        patchutils \
        bc \
        zlib1g-dev \
        libexpat-dev && \
        #vim && \
        wget -O dtc.deb http://security.ubuntu.com/ubuntu/pool/main/d/device-tree-compiler/device-tree-compiler_${DTS_VERSION}-3_amd64.deb && \
        dpkg -i dtc.deb && \
        wget -O renode.deb https://github.com/renode/renode/releases/download/v${RENODE_VERSION}/renode_${RENODE_VERSION}_amd64.deb && \
        apt install -y ./renode.deb && \
        rm dtc.deb renode.deb && \
        rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


RUN wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements.txt && \
        wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-base.txt && \
        wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-build-test.txt && \
        wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-doc.txt && \
        wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-run-test.txt && \
        wget -q https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-extras.txt && \
        pip3 install wheel &&\
        pip3 install -r requirements.txt && \
        pip3 install west &&\
        pip3 install sh


RUN wget -q "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZSDK_VERSION}/zephyr-sdk-${ZSDK_VERSION}-setup.run" && \
        sh "zephyr-sdk-${ZSDK_VERSION}-setup.run" --quiet -- -d /opt/toolchains/zephyr-sdk-${ZSDK_VERSION} && \
        rm "zephyr-sdk-${ZSDK_VERSION}-setup.run"

RUN wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
        chmod +x cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
        ./cmake-${CMAKE_VERSION}-Linux-x86_64.sh --skip-license --prefix=/usr/local && \
        rm -f ./cmake-${CMAKE_VERSION}-Linux-x86_64.sh

#RUN mkdir /opt/toolchains/qemu && \
#    git clone https://github.com/qemu/qemu.git && \
#    cd qemu && \
#    git checkout v4.2.0 && \
#    ./configure --target-list=riscv64-softmmu,riscv32-softmmu --prefix=/opt/toolchains/qemu && \
#    make -j 10 && \
#    make install && \
#    cd .. && \
#    rm -rf qemu

#RUN mkdir /opt/toolchains/riscv && \
#    git clone https://github.com/riscv/riscv-gnu-toolchain && \
#    cd riscv-gnu-toolchain && \
#    git submodule update --init --recursive && \
#    ./configure --prefix=/opt/toolchains/riscv --enable-multilib && \
#    make -j 10 && \
#    make build-qemu -j 10

RUN mkdir /opt/toolchains/riscv-gnu-toolchain

# Setup user
RUN groupadd -g $GID -o user

RUN useradd -u $UID -m -g user -G plugdev user \
        && echo 'user ALL = NOPASSWD: ALL' > /etc/sudoers.d/user \
        && chmod 0440 /etc/sudoers.d/user

# Set the locale
ENV ZEPHYR_TOOLCHAIN_VARIANT=zephyr
ENV ZEPHYR_SDK_INSTALL_DIR=/opt/toolchains/zephyr-sdk-${ZSDK_VERSION}
ENV ZEPHYR_BASE=/workspace
ENV PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig
ENV DISPLAY=:0

RUN chown -R user:user /home/user
#
# More information: https://www.gitpod.io/docs/config-docker/
