# MongoDB Kafka Connector Lite

This docker compose spins up the following:
- MongoDB single node replica set
- Kafka Connect
- Kafka Broker
- Kafka Zookeeper

In this example, we will spin up a bare bones MongoDB and Apache Kafka configuration.  It will contain a single node replica set MongoDB cluster, Apache Kafka, Apache Kafka Connect (with the MongoDB Connector for Apache Kafka installed), Apache Zookeeper (required by Apache Kafka)

## Usage

To start the services 

    docker-compose up -d

Once you have started the service run the following command to enter the shell:

    docker exec -it shell /bin/sh

Once you are in the shell run the following command to connect to the replica
set: 

    mongosh mongodb://mongo1:27017/?replicaSet=rs0

Once you connect to the replica set, run these commands in the mongodb shell to
upload a document to the `source` collection in the `quickstart` database:

    use quickstart
    db.source.insertOne({"hello":"kafka"})

After you insert a document, wait 5-10 seconds and run the following command:

    db.sink.find()

You should see a document resembling the following in your output:

    {"_id":{"$oid":"60f4a0b1f076371c9182abdb"},"schema":{"optional":false,"type":"string"},"payload":"{\"_id\": {\"_data\": \"8260F4A0AE000000012B022C0100296E5A1004F4C4647110574987AB690F0A1FD09B0046645F6964006460F4A0AEB9CA02DFBEF95FC80004\"}, \"operationType\": \"insert\", \"clusterTime\": {\"$timestamp\": {\"t\": 1626644654, \"i\": 1}}, \"fullDocument\": {\"_id\": {\"$oid\": \"60f4a0aeb9ca02dfbef95fc8\"}, \"hello\": \"kafka\"}, \"ns\": {\"db\": \"quickstart\", \"coll\": \"source\"}, \"documentKey\": {\"_id\": {\"$oid\": \"60f4a0aeb9ca02dfbef95fc8\"}}}"}

This is a pretty hard to read format. To configure the connector to a format our
output connector delete the current connector configuration and upload a new one
using these commands:

    curl -X DELETE http://connect:8083/connectors/mongo-sink
    curl -X POST -H "Content-Type: application/json" --data @sink-connector-cdc.json http://connect:8083/connectors -w "\n"

Now go into mongo db an insert another document:

    use quickstart
    db.source.insertOne({"welcome":"kafka"})

Now run the following command:

    db.sink.find()

You should see a document resembling the following:

    {"_id":{"$oid":"60f4d4af6e615c38a77c59c6"},"welcome": "kafka"}

To stop the process you can use "Control-C" or `docker-compose down -v`
