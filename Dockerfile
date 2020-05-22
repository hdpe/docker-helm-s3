FROM alpine

ARG VERSION=3.2.1
ARG CHECKSUM=018f9908cb950701a5d59e757653a790c66d8eda288625dbb185354ca6f41f6b

RUN apk add --no-cache git bash curl && \
    cd /tmp && \
    curl -o helm.tar.gz https://get.helm.sh/helm-v$VERSION-linux-amd64.tar.gz && \
    echo "$CHECKSUM  helm.tar.gz" | sha256sum -c - && \
    tar xzf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/ && \
    rm -rf /tmp/linux-amd64 && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git

ENTRYPOINT ["/usr/local/bin/helm"]
