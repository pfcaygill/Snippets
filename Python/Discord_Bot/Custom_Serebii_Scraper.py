# using the base starting point of https://kaijento.github.io/2017/05/01/web-scraping-serebii.net/
# which is an article on web scraping using move data from serebii (pokemon based website)
# this is because at the time of writing the data set collected is being updated with new pokemon catch rates

import requests
from bs4 import BeautifulSoup

# this whole code is going to be blocking, so the actuall process here doesn't much matter

# The value used in order to get the full list of names of pokemon for future scraping
GalarDexURL = 'https://www.serebii.net/swordshield/galarpokedex.shtml'
# The value that will have the pokemon name appended to it in order to scrape individual catch rates
BaseEntryURL = 'http://serebii.net'

# To start with, request the correct page
reqGalarDex = requests.get(GalarDexURL, headers={'user-agent':'Mozilla/5.0'})
galarDexSoup = BeautifulSoup(reqGalarDex.content, 'html5lib')
# Find the second table on the page
table = galarDexSoup.find('main').findChild('table').find_next_sibling('table')
# Skip the first two rows of the table by finding the special value of the first non useful row
startingPoint = table.find('tr').find_next_sibling('tr')
# Set up our list of urls to navigate to
pokedex = []
# Then, iterate over the siblings
for sibling in startingPoint.next_siblings:
    try:
        entry = sibling.findChild('a').get('href')
        pokedex.append(entry)
        #Print an indicator that we have not frozen the machine
        print('#', end= "", flush= True)
    except:
        pass

# Tells us we have been successfull
print ('\nFound ' + str(len(pokedex)) + ' entries') 
print ('Sample 1: ' + str(pokedex[0]))
print ('Starting secondary scrape')

# Move on to the second part of the process: scraping the individual pages 
# We need to put our individual rates mapped to the individual pokemon
CatchRates = {}
# We also need to write to a file
FileOut = open("./Data/Pokemon_Catch_Rates.txt","x")
# Now soup each page
for pokemon in pokedex:
    # Get our pokedex entry soup
    # Our ref looks like "/pokedex-swsh/runerigus/"
    dexEntryURL = BaseEntryURL + str(pokemon)
    reqDexEntry = requests.get(dexEntryURL, headers={'user-agent':'Mozilla/5.0'})
    entrySoup = BeautifulSoup(reqDexEntry.content, 'html5lib')
    # We need to go the tricky way to find the name
    row = entrySoup.find('td', string='Gender Ratio').find_parent('tr').find_next_siblings('tr')[2]
    catchRate = row.find_all('td')[3].text
    # Strip the start off the string for the pokemon name
    pokemonName = pokemon[14:-1]
    # Now store the dict entry as name -> number
    CatchRates[pokemonName] = catchRate
    # Print out our success (optional)
    print(pokemonName + str(catchRate))
    # Lastly store our scraped data in a file in the data folder
    FileOut.write(pokemonName + ',' + catchRate + '\n')
# And close our file
FileOut.close()