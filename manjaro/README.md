# base-manjaro 

https://github.com/manjaro/manjaro-docker
https://hub.docker.com/r/manjarolinux/build

## working env and tools

- https://webinstall.dev/webi/
## S6

### Services

#### systemd

- https://systemd.io/CONTAINER_INTERFACE/

- https://medium.com/swlh/docker-and-systemd-381dfd7e4628
- https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container
- https://unix.stackexchange.com/questions/305340/how-to-run-systemd-services-in-arch-linux-docker-container
- https://www.hippolab.ru/zapuskaem-systemd-v-docker-konteynere

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

