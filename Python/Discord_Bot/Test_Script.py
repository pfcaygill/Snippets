from Discord_Bot_Database_Handler import DBHandler
import Pokemon_Stat_Calculator

def DatabaseTest():
    test = DBHandler()
    result = test.retrieveCatchRate("runerigus")
    print(result)

    result = test.namesLike('a')
    print(result)

def StatTest(hp:int, hpPercentCurrent:int, rate:int, level:int, status:str):
    # Use the raw stats of Caterpie
    catchTable = Pokemon_Stat_Calculator.determineCatchTable(
        hp, hpPercentCurrent, rate, level, status    
    )
    print ('Ball -> Catch rate out of 255')
    for ball in Pokemon_Stat_Calculator.ballOptions.keys():
        print (ball + '->(' + '-'.join(catchTable[ball]) + ')/255')

def DataStatTest():
    test = DBHandler()
    result = test.retrieveDetails("qwilfish")
    print(result)
# Caterpie
#StatTest(45, 30, 255, 5, 'paralyze')
print('-----------------------------------------')
# Qwilfish
#StatTest(80, 20, 45, 60, 'none')
DataStatTest()