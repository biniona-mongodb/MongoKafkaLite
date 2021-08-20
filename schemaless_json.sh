curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-source",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"source",
         "output.format.value":"json",
         "output.format.key":"json",
         "key.converter.schemas.enable":false,
         "value.converter.schemas.enable":false,
         "key.converter":"org.apache.kafka.connect.json.JsonConverter",
         "value.converter":"org.apache.kafka.connect.json.JsonConverter"
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
         "key.converter.schemas.enable":false,
         "value.converter.schemas.enable":false,
         "key.converter":"org.apache.kafka.connect.json.JsonConverter",
         "value.converter":"org.apache.kafka.connect.json.JsonConverter"
         }
     }
     ' \
     http://connect:8083/connectors -w "\n"

