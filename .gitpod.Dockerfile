FROM gitpod/workspace-full-vnc
USER gitpod

ENV PIP_USER=false
ENV PLATFORMIO_PENV_DIR=/home/gitpod/.platformio
ENV PATH="${PLATFORMIO_PENV_DIR}/bin:${PATH}"
RUN python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
# RUN sudo apt-get update && sudo apt-get -y install ruby-full build-essential zlib1g-dev
# ENV GEM_HOME="$HOME/gems"
# ENV PATH="$HOME/gems/bin:$PATH"
# RUN gem install jekyll bundler
ENV RENODE_VERSION=1.11.0
# Install main dependencies and some useful tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates sudo wget && rm -rf /var/lib/apt/lists/* && \
    wget https://github.com/renode/renode/releases/download/v${RENODE_VERSION}/renode_${RENODE_VERSION}_amd64.deb && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends ./renode_${RENODE_VERSION}_amd64.deb python3-dev && \
    rm ./renode_${RENODE_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*
   
RUN pip3 install -r /opt/renode/tests/requirements.txt --no-cache-dir
