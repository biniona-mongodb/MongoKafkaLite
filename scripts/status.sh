echo "\nKafka topics:\n"

curl --silent "http://broker:8082/topics" | jq

echo "\nThe status of the connectors:\n"

curl -s "http://connect:8083/connectors?expand=info&expand=status" | \
           jq '. | to_entries[] | [ .value.info.type, .key, .value.status.connector.state,.value.status.tasks[].state,.value.info.config."connector.class"]|join(":|:")' | \
           column -s : -t| sed 's/\"//g'| sort

echo "\nCurrently configured connectors\n"
curl --silent -X GET http://connect:8083/connectors | jq

echo "\n\nVersion of MongoDB Connector for Apache Kafka installed:\n"
curl --silent http://connect:8083/connector-plugins | jq -c '.[] | select( .class == "com.mongodb.kafka.connect.MongoSourceConnector" or .class == "com.mongodb.kafka.connect.MongoSinkConnector" )'
