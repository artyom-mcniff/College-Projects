import couchdb
import mariadb
import datetime

# Set up the connection to CouchDB
# Replace with your admin credentials and CouchDB server URL
couch = couchdb.Server("http://admin:couchdb@127.0.0.1:5984")
db_name = "fact_votes"
db = couch[db_name]

design_doc = {
    "_id": "_design/search_participants",
    "views": {
        "by_participant_name": {
            "map": "function (doc) { if (doc.part_name) emit(doc.part_name, doc.ed_year, doc.view_sk, null); }"
        }
    }
}

# Save the design document
try:
    db[design_doc["_id"]] = design_doc
    print("Design document created.")
except couchdb.ResourceConflict:
    print("Design document already exists.")

print("Retrieving all instances of a viewer voting for Joanna Allen")
# Query the view to search for documents with a specific county name
county_name_to_search = 'Joanna Allen'  # Replace with the county name you're looking for
view_result = db.view('search_participants/by_participant_name', key=county_name_to_search)

# Print the results
for row in view_result:
    doc_id = row.id
    doc = db[doc_id]
    print(f"Document ID: {doc_id}, Participant Name: {doc['part_name']}, Edition: {doc['ed_year']}, Viewer ID: {doc['view_sk']}")