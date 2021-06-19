import json

# get item list from yml file and convert into ungrouped file.
def getItemName(infilename='baseworth.yml'):
    rawindex = {}
    with open(infilename) as worth:
        for line in worth:
            line = line.strip()
            if len(line) > 0 and line[0] != '#':
                parts = line.split(':')
                if len(parts) == 2:
                    rawindex[parts[0].lower()] = {'buy': 16, 'sell': 64, 'price' : float(parts[1])}
    #with open(outfilename, mode='w') as file:
    #    json.dump(rawindex, file, indent=2)
    return rawindex

# group item into category
def groupItems(rawindex):
    groupindex = {'block': {}, 'dye': {}, 'food': {}, 'item': {}, 'log': {}, 'ore': {}, 'misc': {}}
    for name, entry in rawindex.items():
        if '_dye' in name:
            groupindex['dye'][name] = entry
        elif 'cooked_' in name or '_seed' in name or '_bean' in name or '_mushroom' in name or '_fungus' in name or 'melon' in name or 'sugar' in name or 'sweet' in name or 'fish' in name or \
                name in ['cod', 'apple', 'bamboo', 'beetroot', 'beef', 'chicken', 'mutton', 'porkchop', 'bread', 'cactus', 'carrot', 'potato', 'pumpkin', 'rabbit', 'salmon', 'chorus_fruit', \
                         'egg', 'nether_wart', 'honey_bottle', 'honeycomb', 'wheat']:
            groupindex['food'][name] = entry
        elif '_log' in name or '_stem' in name:
            groupindex['log'][name] = entry
        elif ('block' in name and 'grass' not in name) or '_ingot' in name or 'redstone' in name or 'lapis' in name or name in ['ancient_debris', 'emerald', 'diamond', 'coal']:
            groupindex['ore'][name] = entry
        elif 'stone' in name or 'sand' in name or 'deepslate' in name or 'obsidian' in name or \
                name in ['andesite', 'basalt', 'diorite', 'dirt', 'gravel', 'netherrack', 'ice', 'grass_block', 'quartz', 'sponge', 'shroomlight']:
            groupindex['block'][name] = entry
        elif 'horse' in name or 'prismarine_' in name or 'ball' in name or \
                name in ['arrow', 'blaze_rod', 'bone', 'string', 'feather', 'flint', 'rabbit_foot', 'leather', 'rotten_flesh', 'ghast_tear', 'gunpowder', 'saddle', 'spider_eye', 'ender_pearl', \
                         'lead', 'ink_sac', 'phantom_membrane', 'nether_star', 'name_tag', 'scute', 'turtle_egg']:
            groupindex['item'][name] = entry
        else:
            groupindex['misc'][name] = entry
    #for category, items in groupindex.items():
    #    print(category, ':', items)
    return groupindex

def writeItemIndex(groupindex, outfilename='index.json'):
    with open(outfilename, mode='w') as file:
        json.dump(groupindex, file, indent=2)

def readItemIndex(infilename='index.json'):
    with open(infilename) as file:
        return json.load(file)

# generate price scoreboard commands
def convertScoreboard(groupindex, adjust=10.0):
    scoreboardCommands = []
    for group, collection in groupindex.items():
        for name, entry in collection.items():
            price = round(entry['price'] * adjust)
            scale = entry['scale'] if 'scale' in entry else 2
            if 'buy' in entry:
                for buyamount in entry['buy'] if type(entry['buy']) is list else (entry['buy'],):
                    if buyamount == 1:
                        scoreboardCommands.append('scoreboard players set ' + name + '_buy Price ' + str(price * scale))
                    else:
                        scoreboardCommands.append('scoreboard players set ' + name + '_buy_' + str(buyamount) + ' Price ' + str(price * scale * buyamount))
            if 'sell' in entry:
                for sellamount in entry['sell'] if type(entry['sell']) is list else (entry['sell'],):
                    if sellamount == 1:
                        scoreboardCommands.append('scoreboard players set ' + name + '_sell Price ' + str(price))
                    else:
                        scoreboardCommands.append('scoreboard players set ' + name + '_sell_' + str(sellamount) + ' Price ' + str(price * sellamount))
    return scoreboardCommands

# generate command text
def createCommands(groupindex):
    groupCommandText = {}
    spacer_buy = ('''#@ keep
#@ impulse
#@ manual
execute at @p[distance=..3] if score @p[distance=0] Wallet < ''', ''' Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute at @p[distance=..3] unless entity @a[scores={Transaction=3}] if score @p[distance=0] Wallet >= ''', ''' Price run scoreboard players set @p[distance=0,scores={Transaction=0}] Transaction 3
#@ conditional
scoreboard players operation @p[scores={Transaction=3}] Wallet -= ''', ''' Price
#@ conditional
give @p[scores={Transaction=3}] ''', '''
#@ conditional
tellraw @p[scores={Transaction=3}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=3}] Transaction 0''') # len=5
    spacer_sell = ('''#@ keep
#@ impulse
#@ manual
execute at @p[distance=..3] unless entity @p[distance=0,nbt={Inventory:[{''','''}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute at @p[distance=..3] unless entity @a[scores={Transaction=4}] run scoreboard players set @p[distance=0,scores={Transaction=0},nbt={Inventory:[{''','''}]}] Transaction 4
#@ conditional
clear @p[scores={Transaction=4}] ''', '''
#@ conditional
scoreboard players operation @p[scores={Transaction=4}] Wallet += ''',''' Price
#@ conditional
tellraw @p[scores={Transaction=4}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=4}] Transaction 0''') # len=5
    for group, collection in groupindex.items():
        groupCommandText[group] = {}
        for name, entry in collection.items():
            groupCommandText[group][name] = {}
            if 'buy' in entry:
                groupCommandText[group][name]['buy'] = []
                for buyamount in entry['buy'] if type(entry['buy']) is list else (entry['buy'],):
                    score_buy = name + ('_buy' if entry['buy'] == 1 else '_buy_' + str(entry['buy']))
                    give_buy = name if entry['buy'] == 1 else name + ' ' + str(entry['buy'])
                    groupCommandText[group][name]['buy'].append(spacer_buy[0] + score_buy + spacer_buy[1] + score_buy + spacer_buy[2] + score_buy + spacer_buy[3] + give_buy + spacer_buy[4])
            if 'sell' in entry:
                groupCommandText[group][name]['sell'] = []
                for sellamount in entry['sell'] if type(entry['sell']) is list else (entry['sell'],):
                    nbt_sell = 'id:"minecraft:' + name + ('"' if entry['sell'] == 1 else '",Count:' + str(entry['sell']) + 'b')
                    clear_sell = name + ' ' + str(entry['sell'])
                    score_sell = name + ('_sell' if entry['sell'] == 1 else '_sell_' + str(entry['sell']))
                    groupCommandText[group][name]['sell'].append(spacer_sell[0] + nbt_sell + spacer_sell[1] + nbt_sell + spacer_sell[2] + clear_sell + spacer_sell[3] + score_sell + spacer_sell[4])
    return groupCommandText

# convert command text into single command
def singleCommands(groupCommandText):
    import SingleCommandGenerator
    groupCommandSingle = {}
    for group, collection in groupCommandText.items():
        groupCommandSingle[group] = {}
        for name, entry in collection.items():
            groupCommandSingle[group][name] = {}
            for key, commandText in entry.items():
                groupCommandSingle[group][name][key] = []
                for command in commandText:
                    groupCommandSingle[group][name][key].append(SingleCommandGenerator.parse(command.split('\n'), outfile=False))
    return groupCommandSingle

def convertCommands(groupCommandSingle, buy = True, sell = True):
    import SingleCommandGenerator
    singleCommands = []
    def new_commandlist():
        return ['#@ positive-x', '#@ skip 1', '#@ default impulse']
    for group, collection in groupCommandSingle.items():
        singleCommands.append('#@ ' + group)
        count = 0
        commandlist = new_commandlist()
        for name, entry in collection.items():
            if buy and 'buy' in entry:
                for command in entry['buy']:
                    commandlist.append(command)
            commandlist.append('summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,Small:1b,DisabledSlots:16191,ArmorItems:[{},{},{},{id:' + name + ',Count:1b}]}')
            if buy and 'sell' in entry:
                for command in entry['sell']:
                    commandlist.append(command)
            count += 1
            if count == 3:
                singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
                commandlist = new_commandlist()
                count = 0
            else:
                commandlist.append('/')
        if count != 0:
            singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return singleCommands


if __name__ == '__main__':
    #rawindex = getItemName()
    #groupindex = groupItems(rawindex)
    #writeItemIndex(groupindex)
    groupindex = readItemIndex()
    scoreboardCommands = convertScoreboard(groupindex)
    #print('\n'.join(scoreboardCommands))
    groupCommandText = createCommands(groupindex)
    #print(json.dumps(groupCommandText, indent=2))
    groupCommandSingle = singleCommands(groupCommandText)
    #print(json.dumps(groupCommandSingle, indent=2))
    singleCommands = convertCommands(groupCommandSingle)
    for item in singleCommands: print(item);
