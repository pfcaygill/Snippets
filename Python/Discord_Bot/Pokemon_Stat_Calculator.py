# Determine the stats of a pokemon
# Sourced from https://bulbapedia.bulbagarden.net/wiki/Individual_values#Determination_of_stats_2

statusOptions = {
    'sleep':2.0,
    'freeze':2.0,
    'paralyze':1.5,
    'poison':1.5,
    'burn':1.5
}

ballOptions = {
    'Poke Ball':1,
    'Great Ball':1.5,
    'Ultra Ball':2,
    'Lure Ball':5,
    'Dive/Net Ball':3.5,
    'Repeat Ball':3.5,
    'Timer Ball':4,
    'Luxury/Premier Ball':1,
    'Dusk Ball':3,
    'Quick Ball':5
}

def determineHP(base:int, level:int, IV:int, EV:int):
    return (
            (( 2 * base + IV + (EV/4)) * level) 
            / 100 ) + level + 10

def determineCatchResult(hpMax:float, hpCurrent:float, rate:int, ball:float, status:float):
    return int(((((3 * hpMax) - (2 * hpCurrent)) * rate * ball)
            /(3 * hpMax)) * status)

def determineStatusMult(status:str):
    if status in statusOptions.keys():
        return statusOptions[status]
    else:
        return 1.0


def determineCatchTable(hp:int, hpPercentCurrent:int, rate:int, level:int, status:str):
    # We will need to determine the current hp and the max hp from our given approximations
    # We will generate a range of chances based upon the possible hp IV
    # IVs range from 0-31
    lowHPTotal = determineHP(hp, level, 0, 0)
    highHPTotal = determineHP(hp, level, 31, 0)
    lowHPCurrent = (hpPercentCurrent / 100.0) * lowHPTotal 
    highHPCurrent = (hpPercentCurrent / 100.0) * highHPTotal
    # Now we need the status multiplyer
    statusMult = determineStatusMult(status)
    # Now, for each ball we can calculate the likelihood
    catchResults = {}
    for ball in ballOptions.keys(): 
        catchResults[ball] = (str(determineCatchResult(
            lowHPTotal,
            lowHPCurrent,
            rate,
            ballOptions[ball],
            statusMult
            )), str(determineCatchResult(
            highHPTotal,
            highHPCurrent,
            rate,
            ballOptions[ball],
            statusMult
            )))
    return catchResults