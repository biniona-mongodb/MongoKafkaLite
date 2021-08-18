curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-source",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"source",
         "publish.full.document.only":true,
         "errors.tolerance":"all",
         "mongo.errors.deadletterqueue.topic.name":"errors",
         "output.format.value":"schema",
         "output.schema.value":"{\"type\": \"record\", \"name\": \"test\", \"fields\": [{\"type\": \"string\", \"name\": \"title\"}, {\"type\": \"string\", \"name\": \"_id\"}]}",
         "output.format.key":"json",
         "key.converter":"org.apache.kafka.connect.storage.StringConverter",
         "value.converter":"io.confluent.connect.avro.AvroConverter",
         "value.converter.schema.registry.url":"http://schema-registry:8081"
         }
     }
     ' \
     http://connect:8083/connectors -w "\n"

curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-sink",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"sink",
         "topics":"quickstart.source",
         "key.converter":"org.apache.kafka.connect.storage.StringConverter",
         "value.converter":"io.confluent.connect.avro.AvroConverter",
         "value.converter.schema.registry.url":"http://schema-registry:8081"
         }
     }
     ' \
     http://connect:8083/connectors -w "\n"

