curl --connect-timeout 5 \
     --max-time 10 \
     --retry 6 \
     --retry-delay 0 \
     --retry-max-time 80 \
     --retry-connrefused \
     -X POST -H "Content-Type: application/json" --data '
{ "name":  "mongo-source-CDCTutorial-eventroundtrip",
  "config": {
    "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
    "connection.uri":"mongodb://mongo1:27017,mongo2:27017,mongo3:27017",
    "database":"CDCTutorial","collection":"Source"}
}' http://connect:8083/connectors -w "\n"