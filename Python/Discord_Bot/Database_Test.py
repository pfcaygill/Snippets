from Discord_Bot_Database_Handler import DBHandler

test = DBHandler()
result = test.retrieveCatchRate("runerigus")
print(result)

result = test.namesLike('a')
print(result)