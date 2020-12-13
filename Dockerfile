FROM centos:8
USER root

# -- Add User
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g ${PGID} apiuseuser && \
    useradd -u ${PUID} -g apiuseuser -m apiuseuser

# -- Install Nginx 
RUN dnf install -y git vim nginx
COPY etc/nginx/conf.d/rails.conf /etc/nginx/conf.d/rails.conf
COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
RUN systemctl enable nginx

# -- Mandatory programs
RUN dnf -y install openssl-devel readline-devel zlib-devel gcc make tar bzip2 mysql-devel

# -- Install Ruby  
ARG RUBY_VERSION=2.7.2
ENV RBENV_DIR /root/.rbenv
# rbenvとruby-buildから指定したrubyバージョンをインストール
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_DIR && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_DIR/plugins/ruby-build && \
    $RBENV_DIR/bin/rbenv install ${RUBY_VERSION} && \
    $RBENV_DIR/bin/rbenv global ${RUBY_VERSION}

# Gemにbundlerをインストール
RUN $RBENV_DIR/shims/gem install bundler

# -- Install NodeJS
ARG NODE_VERSION=v15.4.0
# nodebrewより、node.jsをインストールする
RUN curl -L git.io/nodebrew | perl - setup && \
    echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.bashrc && \
    export PATH=$HOME/.nodebrew/current/bin:$PATH && \
    nodebrew install-binary ${NODE_VERSION} && \
    nodebrew use ${NODE_VERSION}

# --Clone Gamefrie-api
ENV APP_DIR=/home/apiuseuser/gamefrie_api
RUN mkdir ${APP_DIR}
RUN git clone https://github.com/AkiUnleash/gamefrie_api_dev ${APP_DIR}
WORKDIR ${APP_DIR}


COPY ./config/unicorn.rb ./config/unicorn.rb
COPY ./lib/tasks/unicorn.rake ./lib/tasks/unicorn.rake