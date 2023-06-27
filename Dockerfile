FROM ubuntu:22.04 AS ubuntu_22_04
LABEL maintainer="Aaron Nel nelaaro@gmail.com"
#ARG install='fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim'
ARG install="ca-certificates apt-transport-https gpg fish curl openssh-server openvpn git neovim\
     jq curl wget make gcc build-essential supervisor tmux fzf sudo p7zip-full nmap ncat hping3 \
     inetutils-ping mtr-tiny "
ARG install2="fzf-fish-plugin yq kubectx fisher mvn"
ARG container-user="aaron"
#RUN echo $install
# curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG kube_version=v1.27.0

ADD rootfs /
# ADD rootfs /

RUN yes | /usr/local/sbin/unminimize \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && yes | /usr/local/sbin/unminimize \
    && apt upgrade -y \
    && apt install -y  ${install}  \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt update \ 
    && apt install -y kubectl 

#    && rm -rf /var/cache/apk/* 

RUN useradd -m -u 501 -G root,staff,sudo -c 'same as macos user account'  -s '/usr/bin/bash' aaron
RUN echo "aaron:itISeasy1!" | /usr/sbin/chpasswd
# RUN chown aaron/home/aaron

USER aaron
# RUN whoami

# RUN curl -sS https://webi.sh/ | sh
RUN curl -sS https://webi.sh/webi | /usr/bin/sh \
    && /usr/bin/bash -c "source ~/.config/envman/PATH.env" \
    && /home/aaron/.local/bin/webi k9s kubectx kubens yq pathman bat rg fd  

RUN (cd $HOME/Downloads && curl -N  --location --remote-header-name --remote-name https://github.com/int128/kubelogin/releases/download/v1.28.0/kubelogin_linux_arm64.zip) \
    && /usr/bin/7z e -o$HOME/.local/opt/kubelogin $HOME/Downloads/kubelogin_linux_arm64.zip \
    && chmod a+x ~/.local/opt/kubelogin/kubelogin \
    && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/kubectl-oidc_login \
    && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/ \
    && ln -s ~/.local/bin/kubectx ~/.local/bin/kubectl-ctx \
    && ln -s ~/.local/bin/kubens ~/.local/bin/kubectl-ns

# Fish and fisher
RUN curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher \
    && /usr/bin/fish -c "fisher install evanlucas/fish-kubectl-completions"


RUN whoami
ADD --chown=aaron:aaron rootfs/home/user/.kube /home/aaron/.kube


# Init
# ENTRYPOINT [ "/init" ]
#ENTRYPOINT [ "/bin/sh" ]
USER root
# https://stackoverflow.com/a/40199614/619760
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
