mongo config-replica.js
# config-replica.js must complete before collections can be built. Need to confirm this
sleep 3
# build collections. I think this needs to happen before connectors can be added. Need to confirm this
mongo config-data.js
sleep 3
# delete connectors and re add them.
curl -X DELETE -H "Content-Type: application/json" http://connect:8083/connectors/mongo-source
curl -X DELETE -H "Content-Type: application/json" http://connect:8083/connectors/mongo-sink
curl -X POST -H "Content-Type: application/json" --data @source-connector.json http://connect:8083/connectors -w "\n"
curl -X POST -H "Content-Type: application/json" --data @sink-connector.json http://connect:8083/connectors -w "\n"
# print all connectors added to kafka connect
curl -X GET http://connect:8083/connectors
