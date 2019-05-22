FROM ruby:2.5.3-stretch
ENV CF_CLI_VERSION="6.42.0"
ENV PACKAGES unzip curl openssl ca-certificates git jq musl util-linux gzip bash uuid-runtime coreutils vim tzdata openssh-client gnupg rsync make zip
RUN apt-get update \
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends $PACKAGES \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -L "https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v${CF_CLI_VERSION}/cf-cli_${CF_CLI_VERSION}_linux_x86-64.tgz" | tar -zx -C /usr/local/bin
RUN curl -L https://github.com/mikefarah/yq/releases/download/1.14.0/yq_linux_amd64 -o yq && chmod +x yq && mv yq /usr/local/bin/yq
RUN ln -s /usr/local/bin/yq /usr/local/bin/yaml
RUN gem install cf-uaac
