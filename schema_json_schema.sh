curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-source",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"source",
         "output.format.value":"schema",
         "output.format.key":"schema",
         "key.converter":"io.confluent.connect.json.JsonSchemaConverter",
         "key.converter.schema.registry.url":"http://schema-registry:8081",
         "value.converter":"io.confluent.connect.json.JsonSchemaConverter",
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
         "key.converter":"io.confluent.connect.json.JsonSchemaConverter",
         "key.converter.schema.registry.url":"http://schema-registry:8081",
         "value.converter":"io.confluent.connect.json.JsonSchemaConverter",
         "value.converter.schema.registry.url":"http://schema-registry:8081"
         }
     }
     ' \
     http://connect:8083/connectors -w "\n"

