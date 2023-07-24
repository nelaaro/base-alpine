#FROM alpine:3.12.0 AS s6-alpine
FROM alpine:latest AS s6-alpine
LABEL maintainer="Aaron Nel nelaaro@gmail.com"
ARG S6_OVERLAY_VERSION=3.1.2.1
ARG S6_OVERLAY_ARCH=x86_64
#ARG S6_OVERLAY_ARCH=aarch64
ARG S6_OVERLAY_DIR=/opt
#ARG S6_OVERLAY_ARCH=noarch
#ARG install='fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim'
ARG install="fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim jq yq kubectxª"
#RUN echo $install
# curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG kube_version=v1.27.0

#ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz
#ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/download/v3.1.2.1/s6-overlay-aarch64.tar.xz
#ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/download/v3.1.2.1/s6-overlay-aarch64.tar.xz
#ENV S6_OVERLAY_RELEASE=${S6_OVERLAY_RELEASE}

ADD rootfs /

# s6 overlay Download
#ADD ${S6_OVERLAY_RELEASE} /tmp/s6overlay.tar.gz

#RUN ls /tmp
# Build and some of image configuration
RUN apk upgrade --update --no-cache \
    && apk add xz ${install} 
#    && rm -rf /var/cache/apk/* 

# Kubectl 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${kube_version}/bin/linux/amd64/kubectl \ 
    && mv /kubectl /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl 


#ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz ${S6_OVERLAY_DIR}
RUN tar -C / -Jxpf ${S6_OVERLAY_DIR}/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_OVERLAY_ARCH}.tar.xz ${S6_OVERLAY_DIR}
RUN tar -C / -Jxpf ${S6_OVERLAY_DIR}/s6-overlay-${S6_OVERLAY_ARCH}.tar.xz
#RUN apk upgrade --update --no-cache \
#    && rm -rf /var/cache/apk/* \
#    && tar xJf /tmp/s6overlay.tar.gz -C / \
#    && rm /tmp/s6overlay.tar.gz

# Init
ENTRYPOINT [ "/init" ]
#ENTRYPOINT [ "/bin/sh" ]
