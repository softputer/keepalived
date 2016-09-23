# Keepalived

### Supported Keepalived versions

You can changed the keepalived version just by changing the ENV KEEPALIVED_VERSION to the your desired version.

### How to use this image

This image is simply a base image for you.  There are several ways for you to get started.

#### Run this `Image`

```dockerfile
docker run -d -e VIP=<vip> -e PRIORITY=100 -e LOCALIP=<localip> -e PEERIP=<peerip> softputer/keepalived
```

VIP: this is the floating ip that can be transferred among several machines.

LOCALIP: this is meant to be the ip originally on eth0.

PEERIP:this is the backup node ip.

#### Define your own master.sh

Master.sh file helps trasffer ips. As the variety of the cloud platforms, there is no common method for you to transfer ip among vms. You have to customize your own master.sh to get this image properly running.

#### Attention

If you have any questions about the usage of this image or the configuration of nginx, you can contact my by email: gyj3023@foxmail.com.
