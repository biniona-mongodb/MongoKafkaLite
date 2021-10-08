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
         "publish.full.document.only":true,
         "output.schema.value":"{\"type\": \"record\", \"name\": \"test\", \"fields\": [{\"type\": \"string\", \"name\": \"title\"}, {\"type\": \"string\", \"name\": \"_id\"}]}",
         "value.converter.schemas.enable":true,
         "value.converter":"org.apache.kafka.connect.json.JsonConverter",
         "key.converter":"org.apache.kafka.connect.storage.StringConverter"
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
         "value.converter.schemas.enable":true,
         "value.converter":"org.apache.kafka.connect.json.JsonConverter",
         "key.converter":"org.apache.kafka.connect.storage.StringConverter"
         }
     }
     ' \
     http://connect:8083/connectors -w "\n"

