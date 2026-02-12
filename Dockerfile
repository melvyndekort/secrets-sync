FROM alpine:3.23

# Install dependencies
RUN apk add --no-cache \
    git \
    age \
    curl \
    openssh-client

# Install SOPS
ARG SOPS_VERSION=3.11.0
RUN curl -sL "https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64" \
    -o /usr/local/bin/sops && \
    chmod +x /usr/local/bin/sops

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
