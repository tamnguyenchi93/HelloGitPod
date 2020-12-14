FROM gitpod/workspace-full

USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
RUN sudo apt-get install libgtk-3-dev libsdl1.2-dev libspice-protocol-dev \
   libspice-server-dev libusb-1.0-0-dev libusbredirhost-dev libtool-bin \
   iasl valgrind texinfo virt-manager qemu-kvm libvirt-bin virtinst \
   libfdt-dev libssl-dev pkg-config help2man gawk libncurses5 \
   libncurses5-dev
RUN sudo apt-get install gperf bison flex texinfo
#
# More information: https://www.gitpod.io/docs/config-docker/
