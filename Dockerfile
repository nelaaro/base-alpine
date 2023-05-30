FROM ubuntu:22.04 AS ubuntu_22_04
LABEL maintainer="Aaron Nel nelaaro@gmail.com"
#ARG install='fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim'
ARG install="ca-certificates apt-transport-https gpg fish curl openssh-server openvpn git neovim jq "
ARG install2="fzf-fish-plugin yq kubectx fisher"

#RUN echo $install
# curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG kube_version=v1.27.0

ADD rootfs /

# s6 overlay Download
#ADD ${S6_OVERLAY_RELEASE} /tmp/s6overlay.tar.gz

#RUN ls /tmp
# Build and some of image configuration
# Kubectl 


RUN apt update \
    && apt upgrade -y \
    && apt install -y  ${install}  \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt update \ 
    && apt install -y kubectl
#    && rm -rf /var/cache/apk/* 


# Kubectl 
# RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
#     && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


# RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${kube_version}/bin/linux/amd64/kubectl \ 
#     && mv /kubectl /usr/bin/kubectl \
#     && chmod +x /usr/bin/kubectl 




# Init
# ENTRYPOINT [ "/init" ]
#ENTRYPOINT [ "/bin/sh" ]
# https://stackoverflow.com/a/40199614/619760
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
