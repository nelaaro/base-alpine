# https://www.hippolab.ru/zapuskaem-systemd-v-docker-konteynere
# https://developers.redhat.com/blog/2019/04/24/how-to-run-systemd-in-a-container#enter_podman
FROM manjarolinux/base AS manjaro-build
LABEL maintainer="Aaron Nel nelaaro@gmail.com"
#ARG install='fish fzf-fish-plugin fisher curl openssh-server openvpn git neovim'
ARG install="base-devel ca-certificates curl fd fish fisher fzf gcc git gnu-netcat gnupg go helix helm inetutils jdk17-openjdk jq \
            k9s kubectl kubectx make man-db man-pages maven mtr neovim nmap openssh openvpn \
            p7zip  podman podman-compose podman-docker ripgrep skopeo ssh-tools sudo supervisor \
            tmux wget yq \
"
# alternatives pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
# alternatives pamac-cli

ARG install2="krew"
ARG container-user="aaron"

ADD rootfs /

# RUN ln -sf /etc/systemd/system/container.target /etc/systemd/system/default.target

RUN pacman -Syy --noconfirm --needed \
    ${install}

# set default start target to not be a ui desktop env
# update ca trust store with easi-ca-chain
RUN systemctl set-default multi-user.target \
    && mandb \
    && curl --output-dir /etc/ca-certificates/trust-source/anchors/  -O http://pki.easi-ms.nl/easi-ca-chain.crt.pem \ 
    && update-ca-trust extract \ 
    && systemctl enable sshd.service \
    && cat /etc/hosts.equinix >> /etc/hosts
#    && \
#    rm -f /var/cache/pacman/pkg/*

RUN groupadd -g 20 staff \
    && useradd -m -u 501 -G root,users,staff -c 'same as macos user account'  -s '/usr/bin/bash' aaron \
    && echo "aaron:itISeasy1!" | /usr/sbin/chpasswd
# RUN echo "aaron:itISeasy1!" | /usr/sbin/chpasswd

# RUN chown aaron/home/aaron
# RUN systemctl get-default \ 
#     && cd /etc/ca-certificates/trust-source/anchors/ \
#     && pwd \

USER aaron
RUN whoami

ADD --chown=aaron home/user/ /home/aaron/
RUN ls -lart /home/aaron/.config/
RUN ls -lart /home/aaron/.*

RUN mkdir -p /tmp/build \
    && cd /tmp/build \
    && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm \
    && yay \
    && yay -S krew-bin --noconfirm \
    && kubectl krew update \
    && kubectl krew list \ 
    && kubectl krew install ctx krew ns oidc-login

RUN whoami
# RUN pwd
# RUN ls -lart
# RUN ls -lart /home/aaron/.config/

RUN curl -sS https://webi.sh/ | sh
# RUN curl -sS https://webi.sh/webi | /usr/bin/sh \
#     && /usr/bin/bash -c "source ~/.config/envman/PATH.env" \
#     && /home/aaron/.local/bin/webi k9s kubectx kubens yq pathman bat rg fd

# # ensure that `kubectl plugin` is able to find the installed apps
# RUN (cd $HOME/Downloads && curl -N  --location --remote-header-name --remote-name https://github.com/int128/kubelogin/releases/download/v1.28.0/kubelogin_linux_arm64.zip) \
#     && /usr/bin/7z e -o$HOME/.local/opt/kubelogin $HOME/Downloads/kubelogin_linux_arm64.zip \
#     && chmod a+x ~/.local/opt/kubelogin/kubelogin \
#     && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/kubectl-oidc_login \
#     && ln -s ~/.local/opt/kubelogin/kubelogin ~/.local/bin/ \
#     && ln -s ~/.local/bin/kubectx ~/.local/bin/kubectl-ctx \
#     && ln -s ~/.local/bin/kubens ~/.local/bin/kubectl-ns \
#     && ln -s /mnt/aaron/.kube ~/.kube \
#     && ln -s /mnt/aaron/.ssh ~/.ssh
#    && ln -s ~/mnt/aaron/.config/containers ~/.config/containers \

# move some configs files into locations that make them easier to use
RUN mkdir -p ~/.local/ ~/Downloads ~/.local/opt ~/.local/bin/ \ 
    && ln -s /mnt/aaron/.kube ~/.kube \
    && ln -s /mnt/aaron/.ssh ~/.ssh


# Fish and fisher
# RUN curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher \
#     && /usr/bin/fish -c "fisher install evanlucas/fish-kubectl-completions"

RUN whoami
# ADD --chown=aaron:aaron rootfs/home/user/ /home/aaron/

# Init
# ENTRYPOINT [ "/init" ]
#ENTRYPOINT [ "/bin/sh" ]
USER root

# ENTRYPOINT ["/usr/bin/sh"]

# https://fedoraproject.org/wiki/How_to_debug_Systemd_problems

# ENV container=docker
# ENV container=podman

# RUN mkdir /run/systemd/container

ENTRYPOINT ["/sbin/init"]

CMD ["--log-level=info"]

STOPSIGNAL SIGRTMIN+3