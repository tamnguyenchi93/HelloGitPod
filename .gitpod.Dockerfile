FROM gitpod/workspace-full-vnc
USER gitpod

ENV PIP_USER=false
ENV PLATFORMIO_PENV_DIR=/home/gitpod/.platformio
ENV PATH="${PLATFORMIO_PENV_DIR}/bin:${PATH}"
RUN python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
RUN sudo apt-get update && sudo apt-get -y install ruby-full build-essential zlib1g-dev
RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc && echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc && echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
RUN gem install jekyll bundler
