from pymongo import MongoClient
import json

mongoUri = "mongodb://10.1.1.253"

connection = MongoClient(mongoUri)
client = connection["open5gs"]
sub_collection = client["subscribers"]

json_file = open('/mnt/ue_sub.json')
subs = json.load(json_file)
insert = sub_collection.insert_many(subs)

connection.close()
