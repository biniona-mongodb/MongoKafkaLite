db = db.getSiblingDB('quickstart')
db.source.insertOne({source:1})
db.sink.insertOne({sink:1})
