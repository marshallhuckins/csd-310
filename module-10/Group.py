import mysql.connector


db = mysql.connector.connect(
    user="wilson_user",
    password="financial!",
    host="127.0.0.1",
    database="wilson_assets",

)

cursor = db.cursor()
cursor.execute("SELECT client_name, client_address, client_phone, client_email, client_startDate, client_id FROM ClientTable")
results1 = cursor.fetchall()
print("----Displaying ClientTable----\n")
for row in results1:
    print("Client Name:", row[0], "\n", "Client Address:", row[1],"\n", "Client Phone:", row[2], "\n", "Client Email:", row[3], "\n", "Client StartDate:", row[4], "\n", "Client ID:", row[5], "\n")
print()

cursor = db.cursor()
cursor.execute("SELECT asset_Type, asset_value, asset_ID, client_id FROM AssetTable")
results1 = cursor.fetchall()
print("----Displaying Asset Table----\n")
for row in results1:
    print("Asset ID:", row[0], "\n", "Asset Type:", row[1], "\n", "Asset Value:", row[2], "\n", "Client ID:", row[3], "\n")
print()

cursor = db.cursor()
cursor.execute("SELECT transaction_ID, transaction_Date, invoice_Number, client_ID, asset_ID FROM TransactionTable")
results1 = cursor.fetchall()
print("----Displaying Transaction Table----\n")
for row in results1:
    print("Transaction ID:", row[0], "\n", "Transaction Type:", row[1], "\n", "Invoice Number:", row[2], "\n", "Client ID:", row[3], "\n", "Asset ID:", row[4], "\n")
print()

cursor.close()

db.close()

