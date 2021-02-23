FROM gitpod/workspace-full-vnc


USER root
RUN useradd -m tamnc && echo "tamnc:1234" | chpasswd && adduser tamnc sudo

USER tamnc
