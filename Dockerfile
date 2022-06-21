FROM ruby:3.1.2-bullseye

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV YQ_VERSION="4.9.6"
ENV CF_CLI_VERSION="7.4.0"
ENV FLY_VERSION="7.7.1"
ENV BOSH_VERSION="7.0.1"
ENV PACKAGES "awscli unzip curl openssl ca-certificates git jq musl util-linux gzip bash uuid-runtime coreutils vim tzdata openssh-client gnupg rsync make zip build-essential zlibc zlib1g-dev ruby-dev libxslt-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev"
RUN apt-get update \
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends $PACKAGES \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -fL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -zx -C /usr/local/bin
RUN curl -fL "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64" -o /usr/local/bin/bosh && chmod +x /usr/local/bin/bosh
RUN curl -fL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq
RUN curl -fL "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly-${FLY_VERSION}-linux-amd64.tgz" | tar -zx -C /usr/local/bin
RUN gem install cf-uaac
