FROM ruby:3.3-bookworm

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV YQ_VERSION="4.26.1"
ENV CF_CLI_VERSION="8.17.0"
ENV FLY_VERSION="7.14.3"
ENV BOSH_VERSION="7.9.15"
ENV CREDHUB_VERSION="2.9.52"
ENV PACKAGES "awscli unzip curl openssl ca-certificates git jq musl util-linux gzip bash uuid-runtime coreutils vim tzdata openssh-client gnupg rsync make zip build-essential zlib1g-dev ruby-dev libxslt-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev xxd"
RUN apt-get update \
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends $PACKAGES \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -fL "https://s3-us-west-1.amazonaws.com/v8-cf-cli-releases/releases/v${CF_CLI_VERSION}/cf8-cli_${CF_CLI_VERSION}_linux_x86-64.tgz" | tar -zx -C /usr/local/bin && chmod +x /usr/local/bin/cf
RUN curl -fL "https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64" -o /usr/local/bin/bosh && chmod +x /usr/local/bin/bosh
RUN curl -fL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq
RUN curl -fL "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly-${FLY_VERSION}-linux-amd64.tgz" | tar -zx -C /usr/local/bin
RUN curl -fL "https://github.com/cloudfoundry/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-amd64-${CREDHUB_VERSION}.tgz" | tar -zx -C /usr/local/bin
RUN gem install cf-uaac
RUN gem install bundler -v 2.5.21
