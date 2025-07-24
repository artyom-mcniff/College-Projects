import couchdb
import mariadb
import datetime

# Set up the connection to CouchDB
# Replace with your admin credentials and CouchDB server URL
couch = couchdb.Server("http://admin:couchdb@127.0.0.1:5984")  
db_name = "fact_votes"  # database name

if db_name in couch:
    db = couch[db_name]
    couch.delete(db_name)
else:
    db = couch.create(db_name)

# Connecting to Mariadb relational database
db_config = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "mariadb",
    "database": "MusicCompDB"# Name of database
}

conn = mariadb.connect(**db_config)
cursor = conn.cursor()
cursor.execute("USE MusicCompDB") # Database where data was inserted


#Retrieve the data
fact_query = "SELECT ed_sk, part_sk, view_sk, cat_sk, votes, votecost FROM FactVotes"
cursor.execute(fact_query)
fact_data = cursor.fetchall()


# Creating a single document for each fact merging dimension data into each fact document
for row in fact_data:
    query = "SELECT catname FROM CatDim WHERE cat_sk = 1"
    edsk=int(row[0])
    partsk=int(row[1])
    viewsk=int(row[2])
    catsk=int(row[3])

    # Retreive edition details
    cursor.execute("SELECT edyear FROM EdDim WHERE ed_sk = %s", (edsk,))
    ed_year = cursor.fetchone()
    ed_year = ed_year[0]
    
    # Retrieve participant details
    cursor.execute("SELECT partname FROM PartDim WHERE part_sk = %s", (partsk,))
    part_name = cursor.fetchone()
    part_name = part_name[0]
    
    # Retrieve viewer details
    cursor.execute("SELECT agegroupdesc FROM ViewDim WHERE view_sk = %s", (viewsk,))
    age_group_desc = cursor.fetchone()
    age_group_desc = age_group_desc[0]

    # Retrieve category details
    cursor.execute("SELECT catname FROM CatDim WHERE cat_sk = %s", (catsk,))
    cat_name = cursor.fetchone()
    cat_name = cat_name[0]

    # Create a document for each fact 
    document = {
        "ed_sk": row[0],
        "ed_year": ed_year,
        "part_sk": row[1],
        "part_name": part_name,
        "view_sk": row[2],
        "age_group_desc": age_group_desc,
        "cat_sk": row[3],
        "cat_name": cat_name,
        "vote": row[4],
        "votecost": row[5],
        "type": "votefact",
    }

    # Insert the document into CouchDB
    
 
    db.save(document)


# Define the design document with the view
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

# Query the view to search for ALL documents returning course name and student name

print("Retrieving all participant names and the year they competed for all facts")
view_result = db.view('search_participants/by_participant_name')
# Print the results
for row in view_result:
    doc_id = row.id
    doc = db[doc_id]
    print(f"Document ID: {doc_id}, Participant Name: {doc['part_name']}, Edition: {doc['ed_year']}, Viewer ID: {doc['view_sk']} ")

print("Retrieving all instances of a viewer voting for Joanna Allen")
# Query the view to search for documents with a specific county name
county_name_to_search = 'Joanna Allen'  # Replace with the county name you're looking for
view_result = db.view('search_participants/by_participant_name', key=county_name_to_search)

# Print the results
for row in view_result:
    doc_id = row.id
    doc = db[doc_id]
    print(f"Document ID: {doc_id}, Participant Name: {doc['part_name']}, Edition: {doc['ed_year']}, Viewer ID: {doc['view_sk']}")



# Close the Mariadb database connection
conn.close()
