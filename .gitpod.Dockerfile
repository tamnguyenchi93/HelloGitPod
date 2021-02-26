FROM gitpod/workspace-full-vnc
USER gitpod

ENV PIP_USER=false
ENV PLATFORMIO_PENV_DIR=/home/gitpod/.platformio
ENV PATH="${PLATFORMIO_PENV_DIR}/bin:${PATH}"
RUN python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
RUN sudo apt-get update && sudo apt-get -y install ruby-full build-essential zlib1g-dev
ENV GEM_HOME="$HOME/gems"
ENV PATH="$HOME/gems/bin:$PATH"
RUN gem install jekyll bundler
