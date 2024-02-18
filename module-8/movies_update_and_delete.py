import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "root",
    "password": "Icemans1!",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)

    print(
        "\n Database user {} connected to MySQL on host {}".format(config["user"], config["host"], config["database"]))

    input("\n\n Press any key to continue...")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)


cursor = db.cursor()

def show_films(cursor, title):
    cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as 'Studio Name' from film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON film.studio_id=studio.studio_id")
    
    films = cursor.fetchall()
    
    print("\n -- {} --".format(title))
    
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))

show_films(cursor, "DISPLAYING FILMS")

    # Perform Insertion of new movie
insertQuery = " INSERT INTO film(film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id) VALUES ('Harry Potter and the Sorcerers Stone', '2001', '152', 'Chris Columbus', (SELECT studio_id FROM studio WHERE studio_name = '20th Century Fox'),(SELECT genre_id FROM genre WHERE genre_name = 'SciFi') );"
db.commit()
cursor.execute(insertQuery)
show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    # Perform Update of Alien movie
updateQuery = " update film set genre_id = (select genre_id from genre where genre_name = 'Horror') where film_name = 'Alien';"
db.commit()
cursor.execute(updateQuery)
show_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

    # Delete Gladiator movie from table
deleteQuery = " delete from film where film_name = 'Gladiator';"
db.commit()
cursor.execute(deleteQuery)
show_films(cursor, "DISPLAYING FILMS AFTER Delete")