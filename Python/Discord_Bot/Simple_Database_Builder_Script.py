# Script converts our simple stripped files into a single database file
import sqlite3

# Create our database file
conn = sqlite3.connect('./Data/BotDatabase.db')

# Grab the cursor
c = conn.cursor()

# Now, open our files and insert them into tables
# Create our basic table of catch rates
c.execute(''' CREATE TABLE pokemon
              ([Pokedex_Number] integer, [Pokemon_Name] text, [Catch_Rate] integer)''')
CatchRateFile = open('./Data/Pokemon_Catch_Rates.txt','r')
DexNumber = 1
for line in CatchRateFile.readlines():
    LineArr = line.split(',')
    c.execute("INSERT INTO pokemon VALUES (?,?,?)", (DexNumber, LineArr[0], LineArr[1]) )
    DexNumber += 1

# Commit the new table and close
conn.commit()
conn.close()
