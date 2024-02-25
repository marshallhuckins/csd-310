import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "root",
    "password": "Frogg3r$2839",
    "host": "127.0.0.1",
    "database": "team_bravo",
    "raise_on_warnings": True
}

db = mysql.connector.connect(**config)

cursor = db.cursor()
assets_name = "Assets"
print("--DISPLAYING {} RECORDS--".format(assets_name))

cursor.execute("SELECT * FROM Assets")
asset = cursor.fetchall()
for row in asset:
    print("Asset ID: {}\nAsset Type: {}\nAsset Value: {}\nClient ID: {}\n".format(row[0], row[1], row[2], row[3]))


clients_name = "Client"
print("--DISPLAYING {} RECORDS--".format(clients_name))

cursor.execute("SELECT * FROM client")
client = cursor.fetchall()
for row in client:
    print("Client ID: {}\nClient Name: {}\nClient Address: {}\nClient Phone: {}\nClient Email: {}\nClient Since: {}\n".format(row[0], row[1], row[2], row[3], row[4], row[5]))


transactions_name = "Transactions"
print("--DISPLAYING {} RECORDS--".format(transactions_name))

cursor.execute("SELECT * FROM transactions")
transaction = cursor.fetchall()
for row in transaction:
    print("Transaction ID: {}\nTransaction Date: {}\nInvoice Number: {}\nClient ID: {}\nAsset ID: {}\n".format(row[0], row[1], row[2], row[3], row[4]))




cursor.close()

db.close()

