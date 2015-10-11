# Docker image for Consul

This is a Docker image influenced heavily by progrium/consul.

## Instructions

To spin up a consul cluster locally:

```
docker run -d --name consul_server1 -v $(pwd)/config:/etc/consul.d cleung2010/consul -config-dir /etc/consul.d
JOIN_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' consul_server1)
docker run -d --name consul_server2 -v $(pwd)/config:/etc/consul.d cleung2010/consul -config-dir /etc/consul.d -join $JOIN_IP
docker run -d --name consul_server3 -v $(pwd)/config:/etc/consul.d cleung2010/consul -config-dir /etc/consul.d -join $JOIN_IP
```
