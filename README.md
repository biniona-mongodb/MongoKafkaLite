# MongoDB Kafka Connector Lite

This docker compose spins up the following:
- MongoDB single node replica set
- Kafka Connect
- Kafka Broker
- Kafka Zookeeper

In this example, we will spin up a bare bones MongoDB and Apache Kafka configuration.  It will contain a single node replica set MongoDB cluster, Apache Kafka, Apache Kafka Connect (with the MongoDB Connector for Apache Kafka installed), Apache Zookeeper (required by Apache Kafka)

## Useage

To start the services 

`docker-compose up`

To stop the process you can use "Control-C" or `docker-compose down -v`

