FROM gitpod/workspace-full

USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
RUN sudo apt-get install -y gperf bison flex texinfo
RUN sduo apt-get install -y libsdl1.2-dev libspice-protocol-dev \
   libspice-server-dev libusb-1.0-0-dev libusbredirhost-dev libtool-bin \
   acpica-tools valgrind texinfo virt-manager qemu-kvm \
   libvirt-daemon-system libvirt-clients virtinst libfdt-dev libssl-dev \
   pkg-config help2man gawk libncurses5 libncurses5-dev
#
# More information: https://www.gitpod.io/docs/config-docker/
