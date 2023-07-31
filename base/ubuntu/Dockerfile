FROM ubuntu:22.04 AS ubuntu_22_04
LABEL maintainer="Aaron Nel nelaaro@gmail.com"
#ARG install='fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim'
ARG install="ca-certificates apt-transport-https gpg fish curl openssh-server openvpn git neovim\
     jq curl wget make gcc build-essential supervisor tmux fzf sudo p7zip-full nmap ncat hping3 \
     inetutils-ping mtr-tiny skopeo podman podman-docker ssh sshpass telnet "
     # fd-find ripgrep
ARG install2="fzf-fish-plugin yq kubectx fisher mvn"
ARG container-user="aaron"
#RUN echo $install
# curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG kube_version=v1.27.0

ADD rootfs /
# ADD rootfs /

# Curl is needed for steps futher down
# hence the two install commands
RUN yes | /usr/local/sbin/unminimize \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && yes | /usr/local/sbin/unminimize \
    && apt upgrade -y \
    && apt install -y  ${install}  \ 
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
    && curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt update \ 
    && apt install -y kubectl helm \
    && mkdir /run/sshd

#    && rm -rf /var/cache/apk/* 

RUN useradd -m -u 501 -G root,staff,sudo -c 'same as macos user account'  -s '/usr/bin/bash' aaron \
    && echo "aaron:itISeasy1!" | /usr/sbin/chpasswd
#RUN echo "aaron:itISeasy1!" | /usr/sbin/chpasswd

# RUN chown aaron/home/aaron

USER aaron
# RUN whoami

# RUN curl -sS https://webi.sh/ | sh
RUN curl -sS https://webi.sh/webi | /usr/bin/sh \
    && /usr/bin/bash -c "source ~/.config/envman/PATH.env" \
    && /home/aaron/.local/bin/webi k9s kubectx kubens yq pathman bat rg fd  

# ensure that `kubectl plugin` is able to find the installed apps
RUN (cd $HOME/Downloads && curl -N  --location --remote-header-name --remote-name https://github.com/int128/kubelogin/releases/download/v1.28.0/kubelogin_linux_arm64.zip) \
    && /usr/bin/7z e -o$HOME/.local/opt/kubelogin $HOME/Downloads/kubelogin_linux_arm64.zip \
    && chmod a+x ~/.local/opt/kubelogin/kubelogin \
    && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/kubectl-oidc_login \
    && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/ \
    && ln -s ~/.local/bin/kubectx ~/.local/bin/kubectl-ctx \
    && ln -s ~/.local/bin/kubens ~/.local/bin/kubectl-ns \
    && ln -s /mnt/aaron/.kube ~/.kube \
    && ln -s /mnt/aaron/.ssh ~/.ssh 
#    && ln -s ~/mnt/aaron/.config/containers ~/.config/containers \

# Fish and fisher
# RUN curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher \
#     && /usr/bin/fish -c "fisher install evanlucas/fish-kubectl-completions"

RUN whoami
ADD --chown=aaron:aaron rootfs/home/user/ /home/aaron/

# Init
# ENTRYPOINT [ "/init" ]
#ENTRYPOINT [ "/bin/sh" ]
USER root
# https://stackoverflow.com/a/40199614/619760
#CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord_docker.conf
