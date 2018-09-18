#!/bin/bash

#set -x

source /scripts/constants
source /scripts/utils.sh
exdir=`executing_dir`

container=dns
container_image=searchathing/dns
#container_data=/nas/data/xxx
net=dns
#net=host
#ip=
ip="$ip_dns_srv"
cpus="3"
memory="384m"

dk-rm-if-exists $container $1

echo -n '---> starting...'

ipargs=""
if [ "$ip" != "" ]; then
	ipargs="--ip=$ip"
fi

privileged=""
#privileged="--privileged"

docker -D run \
        -d \
        -ti \
	-e TZ=`cat /etc/timezone` \
	--name "$container" \
	--hostname "$container" \
        --network="$net" \
	$ipargs \
	$privileged \
        --restart="unless-stopped" \
        --cpus="$cpus" \
        --memory="$memory" \
	--volume="/security/it-admin/root:/root/it-admin-root:ro" \
        "$container_image"

# --volume="$exdir/imgdata/db.rpz:/etc/bind/db.rpz" \

