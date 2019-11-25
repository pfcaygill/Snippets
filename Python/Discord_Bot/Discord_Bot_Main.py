#must be already installed using pip
import discord
from discord.ext import commands
import random

# grab the Token from the seperate data file
TokenFile = open("./Data/Token.txt", "r")
TOKEN = TokenFile.read()
TokenFile.close()

#prep the client
bot = commands.Bot(command_prefix='!')

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
async def pokemon (ctx, name: str):
    return
#Actually start running the bot
bot.run(TOKEN)
