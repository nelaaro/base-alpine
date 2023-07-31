#!/usr/bin/env bash
# auth: aaron 
# email: aaron.nel@capgemini.com
# todo replace xargs with printf and pararam

prefix_path_dev="ddm-dev"
prefix_path_ddm="ddm"
# you need to update the version here
ddmimages=()
ddmimages+=("eco-service-catalog:0.0.2.83009.r17")
ddmimages+=("eco-mandate-service:1.1.19.82861")
ddmimages+=("eco-audit-service:1.0.11.83022")

# So here are all the image version changes for the 7.12 release:

ddmimages+=("auditservice:1.33.4.83070.r17")
ddmimages+=("authservice:1.22.41.83060.r17")
ddmimages+=("bop-service:1.13.5")
ddmimages+=("bvdproxy:1.16.6.83080.r17")
ddmimages+=("cache-service:1.11.6.83071.r17")
ddmimages+=("email-service:1.23.6.83061.r17")
ddmimages+=("gba-password-service:1.10.8.83069.r17")
# ddmimages+=("gba-service:0.15.13.82891") 
ddmimages+=("gbaservice:0.15.15.83068.r17")
ddmimages+=("gmvservice:2.20.5.83081.r17")
ddmimages+=("loginservice:1.21.8.83066.r17")
ddmimages+=("notice-scheduler:1.24.5.83053.r17")
ddmimages+=("notice-service:1.25.6.83079.r17")
ddmimages+=("optout-service:1.21.6.83079")
ddmimages+=("pdfservice:2.22.12.83058.r17")
ddmimages+=("profileservice:1.21.5.83067.r17")
ddmimages+=("servicecatalog:1.21.13.83059.r17")
ddmimages+=("userservice:1.31.7.83062.r17")

# dosn't use the ddm prefix 
ndimages+=("ddm_gateway:1.23.4.83016")
#not found in ace
#not found in ace

# pull from remmote ace to local
# printf "eco-service-catalog:0.0.2.82961\n" | xargs -I@ echo skopeo copy  docker://registry-ddm.ace.nl.capgemini.com/ddm-dev/ddm/@ docker-daemon:registry-ddm.ace.nl.capgemini.com:443/ddm/@
# printf "eco-service-catalog:0.0.2.82961\n" | xargs -I@ echo skopeo copy docker-daemon:registry-ddm.ace.nl.capgemini.com:443/ddm/@ docker://harbor.ddm-acp.k8s.easi/ddm-dev/ddm/@

# push from local to remote ost harbor
# printf "ddm_gateway:1.23.3.82987.r17\n" | xargs -I@ echo skopeo copy docker-daemon:registry-ddm.ace.nl.capgemini.com:443/@ docker://harbor.ddm-acp.k8s.easi/ddm-dev/ddm/@
# printf "eco-service-catalog:0.0.2.82961\n" | xargs -I@ echo skopeo copy docker-daemon:registry-ddm.ace.nl.capgemini.com:443/ddm/@ docker://harbor.ddm-acp.k8s.easi/ddm-dev/ddm/@

function listTags_ace() {
local -n images=${1}
path="${prefix_path_ddm}"
echo "ace tags "
echo -e " list tags from remote registry-ddm.ace.nl.capgemini.com as well as prefix: ${path}"

for i in "${images[@]}"
do
	# echo "# $i"
    image=$(echo $i |  cut -d":" -f1)
	echo "# $i "|  cut -d":" -f1
    #printf "${i}\n" | cut -d":" -f1 | xargs  -I@ echo "skopeo list-tags docker://registry-ddm.ace.nl.capgemini.com/${path}/@ | head -n 1"
    printf "skopeo list-tags docker://registry-ddm.ace.nl.capgemini.com/${path}/%s | head -n 1\n" $image
    # printf "${i}\n" | xargs -I@ echo skopeo list-tags docker://harbor.ddm-acp.k8s.easi/ddm-dev/ddm/@
done
}

function listTags_ost() {
local -n images=${1}
path="${prefix_path_dev}/${prefix_path_ddm}"
#images=$@
echo "ost tags"
echo -e " list tags from remote harbor.ddm-acp.k8s.easi as prefix path ${path}"

for i in "${images[@]}"
do
	# echo "# $i"
    image=$(echo $i |  cut -d":" -f1)
	echo "# $i "|  cut -d":" -f1
    # printf "${i}\n" | xargs -I@ echo skopeo list-tags docker://registry-ddm.ace.nl.capgemini.com/@ 
    #printf "${i}\n" | cut -d":" -f1 | xargs -I@ echo "skopeo list-tags docker://harbor.ddm-acp.k8s.easi/${path}/@ | head -n 1"
    #printf "skopeo list-tags docker://harbor.ddm-acp.k8s.easi/${path}/%s | head -n 1\n" $i
    printf "skopeo list-tags docker://harbor.ddm-acp.k8s.easi/${path}/%s | head -n 1\n" $image
done
}


function copy_ace2l () {
local -n images=$1
path="${prefix_path_dev}/${prefix_path_ddm}"
echo "ace -> local"
echo -e " pull from remote registry-ddm.ace.nl.capgemini.com
retag as local docker-daemon harbor.ddm-acp.k8s.easi/ prefix path ${path}"

for i in "${images[@]}"
do
	echo "# $i"
    # printf "${i}\n" | xargs -I@ echo skopeo copy  docker://registry-ddm.ace.nl.capgemini.com/@ docker-daemon:harbor.ddm-acp.k8s.easi/ddm-dev/@
    printf "${i}\n" | xargs -I@ echo skopeo copy docker://registry-ddm.ace.nl.capgemini.com/${prefix_path_ddm}/@ docker-daemon:harbor.ddm-acp.k8s.easi/${path}@
    printf "echo skopeo copy docker://registry-ddm.ace.nl.capgemini.com/${prefix_path_ddm}/%s docker-daemon:harbor.ddm-acp.k8s.easi/${path}%s\n" $i $i 
done
}


function copy_l2ost() {
local -n images=$1
echo "local -> ost"
echo -e " push from local registry-ddm.ace.nl.capgemini.com or  harbor.ddm-acp.k8s.easi/
to remote docker harbor.ddm-acp.k8s.easi/ prefix path ${path}"

for i in "${images[@]}"
do
	echo "# $i"
    #printf "${i}\n" | xargs -I@ echo skopeo copy docker-daemon:harbor.ddm-acp.k8s.easi/${path}/@ docker://harbor.ddm-acp.k8s.easi/${path}/@
    printf "skopeo copy docker-daemon:harbor.ddm-acp.k8s.easi/${path}/%s docker://harbor.ddm-acp.k8s.easi/${path}/%s\n" $i $i
    printf "skopeo copy docker://registry-ddm.ace.nl.capgemini.com/${path}/%s docker://harbor.ddm-acp.k8s.easi/${path}/%s\n" "$i" "${i//.r17/}"

done
}

function copy_ace2ost () {
local -n images=$1
path="${prefix_path_dev}/${prefix_path_ddm}"
echo "ace -> ost"
echo -e " copy from remote registry-ddm.ace.nl.capgemini.com
retag as remote harbor.ddm-acp.k8s.easi/ prefix path ${path}"

for i in "${images[@]}"
do
    newtag="${i//.r17/}" 
	echo "# $i newtag $newtag"
    # skopeo copy docker://registry-ddm.ace.nl.capgemini.com:443/ddm/userservice:1.31.7.83062.r17 docker://harbor.ddm-acp.k8s.easi/ddm-dev/ddm/userservice:1.31.7.83062
    printf "echo skopeo copy docker://registry-ddm.ace.nl.capgemini.com/${prefix_path_ddm}/%s docker://harbor.ddm-acp.k8s.easi/${path}/%s\n" "$i" "${i//.r17/}"
    #printf "${i}\n" | xargs -I@ echo skopeo copy  docker://registry-ddm.ace.nl.capgemini.com/${prefix_path_ddm}/@ docker://harbor.ddm-acp.k8s.easi/${path}/@
done
}

# echo -e "\n "
# listTags_ace ddmimages
# echo -e "\n "
# listTags_ost ddmimages
# echo -e "\n "
# copy_ace2l ddmimages
# echo -e "\n "
# copy_l2ost ddmimages
echo -e "\n "
copy_ace2ost ddmimages


# prefix_path_ddm=""
# listTags_ace ndimages