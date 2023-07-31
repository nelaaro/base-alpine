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

    sudo openvpn --cd /etc/openvpn --config ./ab14-bo1.ovpn; 
    sudo openvpn --cd /etc/openvpn --config ./ab14-bo1.ovpn; sudo tail -f /tmp/my_openvpn_log

    root@688888ef3b21 /vpn [1]# openvpn --config ./conf/ab14-bo1-continer.ovpn --verb 5

    
    aaron@e24b768b08b5 ~> cd /etc/openvpn/
    aaron@e24b768b08b5 /e/openvpn [1]> sudo openvpn --config ./ab14-bo1.ovpn --verb 5


    sudo bash -c 'cat  /etc/hosts.equinix >> /etc/hosts'

### UPdat ca trust stores

skopeo login harbor.ddm-acp.k8s.easi --username 'robot$ddmacpharbor' --password 8ShiRePAgnxHNuFJqZ4VUbbVRWcInUOK
FATA[0010] authenticating creds for "harbor.ddm-acp.k8s.easi": pinging container registry harbor.ddm-acp.k8s.easi: Get "https://harbor.ddm-acp.k8s.easi/v2/": x509: certificate signed by unknown authority
aa

- https://unix.stackexchange.com/a/698783/4946

RUN curl --output-dir /etc/ca-certificates/trust-source/anchors/  -O http://pki.easi-ms.nl/easi-ca-chain.crt.pem \ 
    && update-ca-trust extract


### podman debug

podman --log-level debug run --systemd=true --env systemd.log_level=debug -it localhost/base-manjaro_cap-vpn-container:latest fish


### podman machine 

[aaron@97405ef5a880 ssh]$ ssh core@host.containers.internal -p 50058 -i /mnt/aaron/.ssh/podman-machine-default
Fedora CoreOS 38.20230709.2.0
Tracker: https://github.com/coreos/fedora-coreos-tracker
Discuss: https://discussion.fedoraproject.org/tag/coreos

Last login: Mon Jul 24 16:02:48 2023 from 192.168.127.1
[core@localhost ~]$


[aaron@97405ef5a880 ssh]$ podman-remote ps
CONTAINER ID  IMAGE                                       COMMAND           CREATED         STATUS         PORTS                   NAMES
97405ef5a880  localhost/manjaro_cap-vpn-container:latest  --log-level=info  23 minutes ago  Up 23 minutes  127.0.0.1:2022->22/tcp  manjaro_cap-vpn-container_1
[aaron@97405ef5a880 ssh]$ cat ~/.config/containers/containers.conf
[containers]

[engine]
  active_service = "podman-machine-default-root"
  [engine.service_destinations]
    [engine.service_destinations.podman-machine-default]
      uri = "ssh://core@host.containers.internal:50058/run/user/501/podman/podman.sock"
      identity = "/mnt/aaron/.ssh/podman-machine-default"
    [engine.service_destinations.podman-machine-default-root]
      uri = "ssh://root@host.containers.internal:50058/run/podman/podman.sock"
      identity = "/mnt/aaron/.ssh/podman-machine-default"

[machine]

[network]

[secrets]

[configmaps]

## after start

sudo bash -c 'cat /etc/hosts.equinix  >> /etc/hosts'
sudo bash -c 'echo -e "\n" >> /etc/hosts'

https://github.com/firecow/gitlab-ci-local
https://stackoverflow.com/questions/32933174/use-gitlab-ci-to-run-tests-locally



sudo bash -c 'cat /etc/hosts.equinix  >> /etc/hosts'
sudo bash -c 'echo -e "\n" >> /etc/hosts'


Details
0. Create a git repo to test this answer

mkdir my-git-project
cd my-git-project
git init
git commit --allow-empty -m"Initialize repo to showcase gitlab-runner locally."
1. Go to your git directory

cd my-git-project
2. Create a .gitlab-ci.yml

Example .gitlab-ci.yml

image: alpine

test:
  script:
    - echo "Hello Gitlab-Runner"
3. Create a docker container with your project dir mounted

docker run -d \
  --name gitlab-runner \
  --restart always \
  -v $PWD:$PWD \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest


docker run -d \
  --name gitlab-runner-maven \
  --restart always \
  -v $PWD:$PWD \
  -v /var/run/docker.sock:/var/run/docker.sock \
  registry-ddm.ace.nl.capgemini.com/gitlab/maven:3.9.2-eclipse-temurin-17

