FROM ruby:2.3-stretch

ENV PACKAGES unzip curl ca-certificates git musl uuid-runtime jq zip vim
RUN apt-get update \
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends $PACKAGES \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.34.1' | tar -zx -C /usr/local/bin
RUN curl -L https://github.com/mikefarah/yq/releases/download/1.14.0/yq_linux_amd64 -o yq && chmod +x yq && mv yq /usr/local/bin/yq
RUN ln -s /usr/local/bin/yq /usr/local/bin/yaml
