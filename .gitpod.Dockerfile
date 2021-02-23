RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

USER docker
