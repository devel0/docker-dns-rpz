# docker-dns-rpz

docker simple dns with response policy zone

## prerequisites

- [docker-ubuntu](https://github.com/devel0/docker-ubuntu)
- [linux-scripts-utils](https://github.com/devel0/linux-scripts-utils)
- `/scripts/constants` : a file with `ip_dns_srv=xxx.yyy.zzz.www` variable declaration
- `/security/it-admin/root` : a file with clear text password of docker root user ( must 600 mode )

## configure

| file | token | replace with |
|---|---|---|
| [imgdata/db.rpz](imgdata/db.rpz) | `my.local` | your local domain ( example: `searchathing.local` |
| | `example.com` | domain name ( example: `searchathing.com` ) |
| | `xxx.yyy.zzz.www` | primary public ip address |
| [imgdata/entrypoint.sh](imgdata/entrypoint.sh) | `my.local` | see above |
| [imgdata/named.conf.options](imgdata/named.conf.options) | `172.19.0.10` | domain controller docker ip |

## build image

```
./build.sh
```

you can specify addictional docker build arguments, example:

```
./build.sh --network=dkbuild
```

## run image

follow create a test named container running an interactive bash terminal

```
docker run --name=test -ti searchathing/dns
```
