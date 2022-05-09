# Proof Setup Instructions

## Docker

### [One Time Only] Remove Existing Docker

Uninstall existing Docker engine:

```bash
sudo systemctl stop docker
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
```

Prune existing images:

```bash
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### [One Time Only] Install Docker

Set up Docker repositories:

```bash
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

Install Docker engine (allow erasing to update dependencies on host):

```bash
sudo yum -y --allow-erasing install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin
```

Start the Docker service and enable it on host startup:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### [One Time Only] Enable Use of Docker without Root

Add the current user to the docker group:

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

Restart docker service:

```bash
sudo systemctl restart docker
```

Log out and log back in for the current user:

```bash
sudo su $USER
```

### [One Time Only] Test Installation

Log into dockerhub:

```bash
docker login
```

Then pull an image:

```bash
docker pull alpine:latest
```

**IMPORTANT:** This should not require use of `sudo`.

## Elasticsearch 

### [One Time Only] Network and Images

Create elastic docker network and pull images for Elasticsearch and Kibana v7.14.2:

```bash
docker network create elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.14.2
docker pull docker.elastic.co/kibana/kibana:7.14.2
```

### Start Elasticsearch

Start the Elasticsearch service as a container:

```bash
docker run --name es01-test --net elastic -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.14.2
```

Wait for logging messages that indicate the service is running. Then check that the 
Elasticsearch service is correctly configured by requesting its root on port 9200:

```bash
curl localhost:9200

# Expect a response like the following:
# {
#   "name" : "d47f05aca623",
#   "cluster_name" : "docker-cluster",
#   "cluster_uuid" : "Cw51g7w8RheMiUPnRUDbMQ",
#   "version" : {
#     "number" : "7.14.2",
#     "build_flavor" : "default",
#     "build_type" : "docker",
#     "build_hash" : "6bc13727ce758c0e943c3c21653b3da82f627f75",
#     "build_date" : "2021-09-15T10:18:09.722761972Z",
#     "build_snapshot" : false,
#     "lucene_version" : "8.9.0",
#     "minimum_wire_compatibility_version" : "6.8.0",
#     "minimum_index_compatibility_version" : "6.0.0-beta1"
#   },
#   "tagline" : "You Know, for Search"
# }
```

### Stop Elasticsearch

Stop the Elasticsearch service:

```bash
docker rm -f 802cb2596bbc
```

Replace the container id with your respective Elasticsearch docker container id.
You can find this out by running:

```bash
docker ps -a

# CONTAINER ID   IMAGE                                                  COMMAND                  CREATED        STATUS                    PORTS                                                NAMES
# 2d7f0bdd7361   docker.elastic.co/kibana/kibana:7.14.2                 "/bin/tini -- /usr/l…"   5 hours ago    Up 5 hours                127.0.0.1:5601->5601/tcp                             kib01-test
# 802cb2596bbc   docker.elastic.co/elasticsearch/elasticsearch:7.14.2   "/bin/tini -- /usr/l…"   5 hours ago    Up 5 hours                127.0.0.1:9200->9200/tcp, 127.0.0.1:9300->9300/tcp   es01-test
# c6d0e6a541d2   hello-world                                            "/hello"                 31 hours ago   Exited (0) 31 hours ago                                                        silly_lewin
```

### Start Kibana

Start the Kibana service as a container:

```bash
docker run --name kib01-test --net elastic -p 127.0.0.1:5601:5601 -e "ELASTICSEARCH_HOSTS=http://es01-test:9200" docker.elastic.co/kibana/kibana:7.14.2
```

Check that the Kibana service is running. To do so, navigate to
[localhost:5601](localhost:5601) in your preferred browser. You should see the Kibana
UI render.

### Stop Kibana

Stop the Kibana service:

```bash
docker rm -f 2d7f0bdd7361
```

Replace the container id with your respective Kibana docker container id.
You can find this out by running:

```bash
docker ps -a

# CONTAINER ID   IMAGE                                                  COMMAND                  CREATED        STATUS                    PORTS                                                NAMES
# 2d7f0bdd7361   docker.elastic.co/kibana/kibana:7.14.2                 "/bin/tini -- /usr/l…"   5 hours ago    Up 5 hours                127.0.0.1:5601->5601/tcp                             kib01-test
# 802cb2596bbc   docker.elastic.co/elasticsearch/elasticsearch:7.14.2   "/bin/tini -- /usr/l…"   5 hours ago    Up 5 hours                127.0.0.1:9200->9200/tcp, 127.0.0.1:9300->9300/tcp   es01-test
# c6d0e6a541d2   hello-world                                            "/hello"                 31 hours ago   Exited (0) 31 hours ago                                                        silly_lewin
```


## Python Backend

### [One-Time Only] Install System Library Dependencies

```bash
sudo yum install -y \
    python3-devel \
    sqlite-devel \
    openssl-devel \
    libffi-devel
```

### [One-Time Only] Install Python

Install [Python 3.10.4](https://www.python.org/downloads/release/python-3104/) from source:

```bash
# Create Directory to Host Python Binaries
mkdir -p $HOME/Downloads/Python/
cd $HOME/Downloads/Python/

# Get Gzipped Source Tarball from Official Python Release
wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
tar -xzvf Python-3.10.4.tgz
cd Python-3.10.4.tgz

# Build Python 3.10.4 from Source
./configure --enable-optimizations
make
sudo make install
```
