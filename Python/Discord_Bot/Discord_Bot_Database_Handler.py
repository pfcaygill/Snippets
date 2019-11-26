import sqlite3

class DBHandler:

    def __init__(self):
        self.conn = sqlite3.connect("./Data/BotDatabase.db")
        self.c = self.conn.cursor()

    def retrieveCatchRate(self, pokemon:str ):
        catchRate = 0
        try :
            catchRate = self.c.execute('''SELECT Catch_Rate
                                          FROM pokemon 
                                          WHERE Pokemon_Name=?''', (pokemon,))
        except :
            return -1
        return int(catchRate.fetchone()[0])

    def namesLike(self, fragment:str):
        try:
            nameList = self.c.execute('''SELECT Pokemon_Name
                                         FROM pokemon
                                         WHERE Pokemon_Name LIKE ? ''', (fragment + '%',))
            return nameList.fetchall()
        except :
            return ()
    
    def retrieveDetails(self, pokemon:str ):
        try :
            details = self.c.execute('''SELECT *
                                          FROM pokemon 
                                          WHERE Pokemon_Name=?''', (pokemon,))
        except :
            return None
        return details.fetchone()
