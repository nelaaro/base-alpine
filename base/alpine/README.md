# base-alpine 

[![Docker Repository on Quay.io](https://quay.io/repository/justcontainers/base-alpine/status "Docker Repository on Quay.io")](https://quay.io/repository/justcontainers/base-alpine)
A simple but powerful base image, based on Alpine Linux

## Getting started

    - https://github.com/ansible/vscode-ansible/wiki/macos
    - 
    podman machine init --cpus=4 --memory=4096 -v $HOME:$HOME -v /private/tmp:/private/tmp -v /var/folders/:/var/folders/


    ❯ podman machine start
    Starting machine "podman-machine-default"
    Waiting for VM ...
    Mounting volume... /Users/aaron:/Users/aaron
    API forwarding listening on: /var/run/docker.sock
    Docker API clients default to this address. You do not need to set DOCKER_HOST.

    Machine "podman-machine-default" started successfully

    podman ps; podman stop base-ubuntu_cap-vpn-container_1; podman rm base-ubuntu_cap-vpn-container_1; podman ps; podman-compose up --build -V -d

### Podman Machine

 - https://docs.podman.io/en/latest/markdown/podman-machine-init.1.html

    podman machine ssh
    Connecting to vm podman-machine-default. To close connection, use `~.` or `exit`
    Fedora CoreOS 38.20230514.2.0
    Tracker: https://github.com/coreos/fedora-coreos-tracker
    Discuss: https://discussion.fedoraproject.org/tag/coreos

Check that volumes are mounted

    Last login: Thu May 25 16:51:17 2023 from 192.168.127.1
    [root@localhost ~]# pwd
    /root
    [root@localhost ~]# cd /Users/aaron/

### Podman-compose 

    ❯ cd ~/project/admin-tools/base-alpine/
    podman-compose up

### vpn

    root@688888ef3b21 /vpn [1]# openvpn --config ./conf/ab14-bo1-continer.ovpn --verb 5

    
    aaron@e24b768b08b5 ~> cd /etc/openvpn/
    aaron@e24b768b08b5 /e/openvpn [1]> sudo openvpn --config ./ab14-bo1.ovpn --verb 5

## working env and tools

- https://webinstall.dev/webi/
## S6

### Services

- https://skarnet.org/software/s6-rc/overview.html
- https://skarnet.org/software/s6-rc/s6-rc-compile.html#source

#### ubuntu

- https://faun.pub/the-top-3-most-important-steps-to-running-supervisord-on-docker-ubuntu-18-04-9c414338824e

### SSL / ca-certificates / certs

Getting certs working inside the container

- https://github.com/containers/podman/blob/main/docs/tutorials/podman-install-certificate-authority.md

## Further reading 

- https://wiki.gentoo.org/wiki/S6



## Versions

 kubectl version
Client Version: version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.3", GitCommit:"06ad960bfd03b39c8310aaf92d1e7c12ce618213", GitTreeState:"clean", BuildDate:"2020-02-11T18:14:22Z", GoVersion:"go1.13.6", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.15", GitCommit:"58178e7f7aab455bc8de88d3bdd314b64141e7ee", GitTreeState:"clean", BuildDate:"2021-09-15T19:18:00Z", GoVersion:"go1.15.15", Compiler:"gc", Platform:"linux/amd64"}

## Troubleshooting

### ToDo

fix dns 

- https://hub.docker.com/r/strm/dnsmasq/
- https://computingforgeeks.com/run-and-use-dnsmasq-in-docker-container/

### 

    listing workers for Build: failed to list workers: Unavailable: connection error: desc = "transport: Error while dialing unable to upgrade to h2c, received 404"

    set -x DOCKER_BUILDKIT 0

    https://stackoverflow.com/a/73242282/619760

- https://blog.while-true-do.io/podman-networking-1/

#### /etc/subuid 

    WARN[0000] "/" is not a shared mount, this could cause issues or missing mounts with rootless containers
    ERRO[0000] cannot find UID/GID for user aaron: No subuid ranges found for user "aaron" in /etc/subuid - check rootless mode in man pages.
    WARN[0000] using rootless single mapping into the namespace. This might break some images. Check /etc/subuid and /etc/subgid for adding sub*ids

- https://www.redhat.com/sysadmin/rootless-podman