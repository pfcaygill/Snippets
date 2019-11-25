#must be already installed using pip
import discord
from discord.ext import commands
import random
from Discord_Bot_Database_Handler import DBHandler

# grab the Token from the seperate data file
TokenFile = open("./Data/Token.txt", "r")
TOKEN = TokenFile.read()
TokenFile.close()

# prep the client
bot = commands.Bot(command_prefix='!')

# add our database handler
db = DBHandler() 

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)

@bot.command()
async def test(ctx):
    ctx.send("Hello and thank you for testing")

@bot.command()
async def roll (ctx, dice: str):
    """Roll a dice in standard XdY format"""
    try:
        rolls, limit = map(int, dice.split('d'))
    except Exception:
        await ctx.send('Please use format XdY eg. 4d6')
        return
    
    resultList = [random.randint(1, limit) for r in range(rolls)]
    #result = ', '.join(resultList)
    resultSum = sum(resultList)
    await ctx.send("Your result is: " + str(resultSum))

@bot.command()
async def pkCatch (ctx, name: str):
    catchrate = db.retrieveCatchRate(name.lower())
    if (catchrate == -1):
        await ctx.send('Pokemon not found')
    else:
        await ctx.send(name + ' has a catch rate of ' + str(catchrate) + '/255')

@bot.command()
async def pkSimilar(ctx, fragment: str):
    nameList = db.namesLike(fragment.lower())
    if len(nameList) >= 1:
        message = 'Found pokemon:\n'
        for option in nameList:
            message += option[0] + '\n'
        await ctx.send(message)
    else:
        await ctx.send('No similar pokemon found')

#Actually start running the bot
bot.run(TOKEN)
