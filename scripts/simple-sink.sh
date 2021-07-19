echo "SINK CONFIGURATION:\n\nTo configure Kafka Connect, we can issue REST calls to the connect service which is listening on port 8083\n\n"

echo -e "$(tput setaf 0)$(tput setab 7)curl -X POST -H \"Content-Type: application/json\" --data @simple-sink-connector.json http://connect:8083/connectors $(tput sgr 0)"

echo "The results of submitting the configuration are as follows:\n"

curl --silent -X POST -H "Content-Type: application/json" --data @simple-sink-connector.json http://connect:8083/connectors -w "\n" | jq .

echo "In this example we configure the Kafka Connector to read data from the 'quickstart.source' topic in Kafka and write the data to the 'quickstart' database, 'sink' collection \n\n"

