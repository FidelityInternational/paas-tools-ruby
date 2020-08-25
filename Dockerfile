FROM ruby:2.7-buster

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV YQ_VERSION="3.2.1"
ENV CF_CLI_VERSION="6.49.0"
ENV FLY_VERSION="5.8.1"
ENV BOSH_VERSION="6.2.1"
ENV PACKAGES "awscli unzip curl openssl ca-certificates git jq musl util-linux gzip bash uuid-runtime coreutils vim tzdata openssh-client gnupg rsync make zip build-essential zlibc zlib1g-dev ruby-dev libxslt-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev"
RUN apt-get update \
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends $PACKAGES \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -fL "https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v${CF_CLI_VERSION}/cf-cli_${CF_CLI_VERSION}_linux_x86-64.tgz" | tar -zx -C /usr/local/bin
RUN curl -fL "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64" -o /usr/local/bin/bosh && chmod +x /usr/local/bin/bosh
RUN curl -fL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq
RUN curl -fL "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly-${FLY_VERSION}-linux-amd64.tgz" | tar -zx -C /usr/local/bin
RUN ln -s /usr/local/bin/yq /usr/local/bin/yaml
RUN gem install cf-uaac
RUN gem install bundler -v 2.0.2