# Dockerfiles for DevOps, CI/CD, Big Data & NoSQL

![](https://i.imgur.com/waxVImv.png)
### [View all Roadmaps](https://github.com/nholuongut/all-roadmaps) &nbsp;&middot;&nbsp; [Best Practices](https://github.com/nholuongut/all-roadmaps/blob/main/public/best-practices/) &nbsp;&middot;&nbsp; [Questions](https://www.linkedin.com/in/nholuong/)
<br/>

### These docker images are tested by hundreds of tools and also used in the full functional test suites of various other GitHub repos.

## Overview - this repo contains:

- **Hadoop & Big Data** ecosystem technologies (Spark, Kafka, Presto, Drill, Nifi, ZooKeeper)
- **NoSQL** datastores (HBase, Cassandra, Riak, SolrCloud)
- OS & development images (Alpine, CentOS, Debian, Fedora, Ubuntu)
- **DevOps**, CI/CD (CircleCI, GitHub Actions, Jenkins, TeamCity etc), open source (RabbitMQ Cluster, Mesos, Consul)
- [My GitHub repos](https://github.com/nholuongut) containing hundreds of tools related to these technologies with all dependencies pre-built in the docker images

These images are all available pre-built on [My DockerHub - https://hub.docker.com/u/nholu](https://hub.docker.com/u/nholu).

- *Quality and Testing* - this repo has entire test suites run against it from various [GitHub repositories](https://github.com/nholuongut) to validate the docker images' functionality, branches vs tagged versions align, latest contains correct version from master branch, syntax checks covering all common build and file formats (Make/JSON/CSV/INI/XML/YAML configurations) etc.

These are reusable tests that can anybody can implement and can be found in my [DevOps Python Tools](https://github.com/nholuongut/DevOps-Python-tools) and [DevOps Bash Tools](https://github.com/nholuongut/DevOps-Bash-tools) repos as well as the which contains hundreds of technology specific API-level test programs to ensure the docker images are functioning as intended.

[Continuous Integration](https://travis-ci.org/nholuongut/dockerfiles) in run on this and adjacent repos that form a bi-directional validation between these docker images and several other repositories full of hundreds of programs. All of this is intended to keep the quality of this repo as high as possible.

## Ready to run Docker images

```shell
docker search nholuongut
docker run nholuongut/nagios-plugins
```

To see more than the 25 DockerHub repos limited by ```docker search``` ([docker issue 23055](https://github.com/docker/docker/issues/23055)) I wrote ```dockerhub_search.py``` using the DockerHub API, available in my [DevOps Python Tools github repo](https://github.com/nholuongut/DevOps-Python-tools) and as a pre-built docker image:

```shell
docker run nholuongut/pytools dockerhub_search.py nholuongut
```

There are lots of tagged versions of official software in my repos to allow development testing across multiple versions, usually more versions than available from the official repos (and new version updates available on request, just [raise a GitHub issue](https://github.com/nholuongut/dockerfiles/issues)).

DockerHub tags are not shown by ```docker search``` ([docker issue 17238](https://github.com/docker/docker/issues/17238)) so I wrote ```dockerhub_show_tags.py``` available in my [DevOps Python Tools github repo](https://github.com/nholuongut/DevOps-Python-tools) and as a pre-built docker image - eg. to see an organized list of all CentOS tags:

```shell
docker run nholuongut/pytools dockerhub_show_tags.py centos
```

For service technologies like Hadoop, HBase, ZooKeeper etc for which you'll also want port mappings, each directory in the [GitHub project](https://github.com/nholuongut/dockerfiles) contains both a standard ` docker-compose ` configuration as well as a ` make run ` shortcut (which doesn't require ` docker-compose ` to be installed) - either way you don't have to remember all the command line switches and port number specifics:

```shell
cd zookeeper
docker-compose up
```

or for technologies with interactive shells like Spark, ZooKeeper, HBase, Drill, Cassandra where you want to be dropped in to an interactive shell, use the ` make run ` shortcut instead:

```shell
cd zookeeper
make run
```

which is much easier to type and remember than the equivalent bigger commands like:

```shell
docker run -ti -p 2181:2181 nholuongut/zookeeper
```

and avoid this for more complex services like Hadoop / HBase:

```shell
docker run -ti -p 2181:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 nholuongut/hbase
```

```shell
docker run -ti -p 8020:8020 -p 8032:8032 -p 8088:8088 -p 9000:9000 -p 10020:10020 -p 19888:19888 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 nholuongut/hadoop
```

Repos suffixed with ```-dev``` are the official technologies + development & debugging tools + my github repos with all dependencies pre-built.

### My GitHub Repos (with all libs + deps pre-built)

You might like this Dockerfile trick for busting the Docker cache to get the latest repo updates:

```Dockerfile
# Cache Bust upon new commits
ADD https://api.github.com/repos/nholuongut/DevOps-Bash-tools/git/refs/heads/master /.git-hashref
```

### Build from Source

All images come pre-built on [DockerHub](https://hub.docker.com/u/nholuongut/) but if you want to compile from source for any reason such as developing improvements, I've made this easy to do:

```shell
git clone https://github.com/nholuongut/dockerfiles

cd Dockerfiles
```

To build all Docker images, just run the ```make``` command at the top level:

```shell
make
```

To build a specific Docker image, enter its directory and run `make`:

```shell
cd nagios-plugins

make
```

You can also build a specific version by checking out the git branch for the version and running the build:

```shell
cd consul
git checkout consul-0.9
make
```

or build all versions of a given software project like so:

```shell
cd hadoop
make build-versions
```

See the top level `Makefile` as well as the `Makefile.in` which is sourced per project with any project specific overrides in the `<project_directory>/Makefile`.

### Support

Please raise tickets for issues and improvements at <https://github.com/nholuongut/dockerfiles/issues>

# 🚀 I'm are always open to your feedback.  Please contact as bellow information:
### [Contact ]
* [Name: nho Luong]
* [Skype](luongutnho_skype)
* [Github](https://github.com/nholuongut/)
* [Linkedin](https://www.linkedin.com/in/nholuong/)
* [Email Address](luongutnho@hotmail.com)
* [PayPal.me](https://www.paypal.com/paypalme/nholuongut)

![](https://i.imgur.com/waxVImv.png)
![](Donate.png)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/nholuong)

# License
* Nho Luong (c). All Rights Reserved.🌟
