# Advanced Nagios Plugins Collection

Specialised plugins for Hadoop, Big Data & NoSQL technologies, written by a former Clouderan ([Cloudera](http://www.cloudera.com) was the first Hadoop Big Data vendor) and current [Hortonworks](http://www.hortonworks.com) consultant.

Hadoop and extensive API integration with all major Hadoop vendors ([Hortonworks](http://www.hortonworks.com), [Cloudera](http://www.cloudera.com), [MapR](http://www.mapr.com), [IBM BigInsights](http://www-03.ibm.com/software/products/en/ibm-biginsights-for-apache-hadoop)), as well as most major open source NoSQL technologies, Pub-Sub / Message Buses, CI, Web and Linux based infrastructure.

Most enterprise monitoring systems come with basic generic checks, while this project extends their monitoring capabilities significantly further in to advanced infrastructure, application layer, APIs etc.


List all plugins:

```
docker run nholuongut/nagios-plugins
```

Run any given plugin by suffixing it to the docker run command:

```
docker run nholuongut/nagios-plugins <program> <args>
```

eg.

```
docker run nholuongut/nagios-plugins check_ssl_cert.pl --help
```


The project is a treasure trove of essentials for every single "DevOp" / sysadmin / engineer, with extensive goodies for people running:

* Web Infrastructure
* [Hadoop](http://hadoop.apache.org/)
* [Kafka](http://kafka.apache.org/)
* [RabbitMQ](http://www.rabbitmq.com/)
* [Mesos](http://mesos.apache.org/)
* [Consul](https://www.consul.io/)

NoSQL technologies:

* [Cassandra](http://cassandra.apache.org/)
* [HBase](https://hbase.apache.org/)
* [MongoDB](https://www.mongodb.com/)
* [Memcached](https://memcached.org/)
* [Couchbase](http://www.couchbase.com/)
* [Redis](http://redis.io/)
* [Riak](http://basho.com/products/)
* [Solr / SolrCloud](http://lucene.apache.org/solr/)
* [Elasticsearch](https://www.elastic.co/products/elasticsearch)

Linux & Infrastructure technologies:

* [Jenkins](https://jenkins.io/)
* [Travis CI](https://travis-ci.org/)
* SSL Certificate expiry
* advanced DNS record checks
* Whois domain expiry check
* [MySQL](https://www.mysql.com/)

and many more ...


Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/nholuongut).
The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/nholuongut/Dockerfiles/).
