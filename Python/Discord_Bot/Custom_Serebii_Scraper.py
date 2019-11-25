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
pile = []
# Then, iterate over the siblings
for sibling in startingPoint.next_siblings:
    try:
        entry = sibling.findChild('a').get('href')
        pile.append(entry)
        #Print an indicator that we have not frozen the machine
        print('#', end= "", flush= True)
    except:
        pass

# Tells us we have been successfull
print ('\nFound ' + str(len(pile)) + ' entries') 
print ('Sample 1: ' + str(pile[0]))
print ('Starting secondary scrape')

# Move on to the second part of the process: scraping the individual pages 
