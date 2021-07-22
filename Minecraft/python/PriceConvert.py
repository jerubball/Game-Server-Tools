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
    groupindex = {'block': {}, 'dye': {}, 'food': {}, 'item': {}, 'log': {}, 'ore': {}, 'potion': {}, 'tool': {}, 'weapon': {}, 'armor': {}, 'misc': {}, 'custom': {}}
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
    scoreboardCommands = ['scoreboard objectives remove Price', 'scoreboard objectives add Price dummy']
    scoreboardNames = {}
    for group, collection in groupindex.items():
        for name, entry in collection.items():
            price = round(entry['price'] * adjust)
            scale = entry['scale'] if 'scale' in entry else 2
            if 'buy' in entry:
                for buyamount in entry['buy'] if type(entry['buy']) is list else (entry['buy'],):
                    key = name + ('_buy' if buyamount == 1 else '_buy_' + str(buyamount))
                    value = price * scale * buyamount
                    scoreboardNames[key] = value
                    scoreboardCommands.append('scoreboard players set ' + key + ' Price ' + str(value))
            if 'sell' in entry:
                for sellamount in entry['sell'] if type(entry['sell']) is list else (entry['sell'],):
                    key = name + ('_sell' if sellamount == 1 else '_sell_' + str(sellamount))
                    value = price * sellamount
                    scoreboardNames[key] = value
                    scoreboardCommands.append('scoreboard players set ' + key + ' Price ' + str(value))
    return scoreboardCommands, scoreboardNames

# pack scoreboard commands
def singleScoreboard(scoreboardCommands):
    import SingleCommandGenerator
    scoreboardSingle = []
    count = 0
    commandlist = []
    for command in scoreboardCommands:
        commandlist.append(command)
        count += 1
        if count == 70:
            scoreboardSingle.append(SingleCommandGenerator.parse(commandlist, outfile=False))
            commandlist = []
            count = 0
    if count != 0:
        scoreboardSingle.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return scoreboardSingle

# generate command text
def createCommands(groupindex, scoreboardNames, button_dir = 'positive-x'):
    groupCommandText = {}
    button_dir = ',facing=west' if button_dir[9] == 'z' else ''
    spacer_tid_buy = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] if score @p[distance=0] Wallet < ''', ''' Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~3 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=''', '''}] if score @p[distance=0] Wallet >= ''', ''' Price run scoreboard players set @p[distance=0] Transaction ''', '''
#@ conditional
execute if block ~ ~4 ~ #buttons[powered=true] run scoreboard players operation @p[scores={Transaction=''', '''}] Wallet -= ''', ''' Price
#@ conditional
execute if block ~ ~5 ~ #buttons[powered=true] run give @p[scores={Transaction=''', '''}] ''', '''
#@ conditional
execute if block ~ ~6 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=''', '''}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~7 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=''', '''}] Transaction 0
execute if block ~ ~8 ~ #buttons[powered=true] run setblock ~ ~8 ~ stone_button[powered=false,face=floor''' + button_dir + ''']''') # len=11
    spacer_tid_sell = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{''','''}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute if block ~ ~3 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=''', '''}] run scoreboard players set @p[distance=0,nbt={Inventory:[{''','''}]}] Transaction ''', '''
#@ conditional
execute if block ~ ~4 ~ #buttons[powered=true] run clear @p[scores={Transaction=''', '''}] ''', '''
#@ conditional
execute if block ~ ~5 ~ #buttons[powered=true] run scoreboard players operation @p[scores={Transaction=''', '''}] Wallet += ''',''' Price
#@ conditional
execute if block ~ ~6 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=''', '''}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~7 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=''', '''}] Transaction 0
execute if block ~ ~8 ~ #buttons[powered=true] run setblock ~ ~8 ~ stone_button[powered=false,face=floor''' + button_dir + ''']''') # len=11
    tid_lookup = {'block': (11,12), 'dye': (13,14), 'food': (15,16), 'item': (17,18), 'log': (19,20), 'ore': (21,22), 'potion': (23,24), 'tool': (25,26), 'weapon': (27,28), 'armor': (29,30), 'misc': (31,32), 'custom': (33,34)}
    for group, collection in groupindex.items():
        tid_buy, tid_sell = tid_lookup[group]
        spacer_buy = (spacer_tid_buy[0],
                      spacer_tid_buy[1] + str(tid_buy) + spacer_tid_buy[2],
                      spacer_tid_buy[3] + str(tid_buy) + spacer_tid_buy[4] + str(tid_buy) + spacer_tid_buy[5],
                      spacer_tid_buy[6] + str(tid_buy) + spacer_tid_buy[7],
                      spacer_tid_buy[8] + str(tid_buy) + spacer_tid_buy[9] + str(tid_buy) + spacer_tid_buy[10]) # len=5
        spacer_sell = (spacer_tid_sell[0],
                       spacer_tid_sell[1] + str(tid_sell) + spacer_tid_sell[2],
                       spacer_tid_sell[3] + str(tid_sell) + spacer_tid_sell[4] + str(tid_sell) + spacer_tid_sell[5],
                       spacer_tid_sell[6] + str(tid_sell) + spacer_tid_sell[7],
                       spacer_tid_sell[8] + str(tid_sell) + spacer_tid_sell[9] + str(tid_sell) + spacer_tid_sell[10]) # len=5
        groupCommandText[group] = {}
        for name, entry in collection.items():
            groupCommandText[group][name] = {}
            if 'buy' in entry:
                groupCommandText[group][name]['buy'] = []
                groupCommandText[group][name]['buy-sign'] = []
                for buyamount in entry['buy'] if type(entry['buy']) is list else (entry['buy'],):
                    score_buy = name + ('_buy' if buyamount == 1 else '_buy_' + str(buyamount))
                    give_buy = name if buyamount == 1 else name + ' ' + str(buyamount)
                    assert score_buy in scoreboardNames
                    price_buy = scoreboardNames[score_buy]
                    groupCommandText[group][name]['buy'].append(spacer_buy[0] + score_buy + spacer_buy[1] + score_buy + spacer_buy[2] + score_buy + spacer_buy[3] + give_buy + spacer_buy[4])
                    groupCommandText[group][name]['buy-sign'].append('{Text1:"{\\"text\\":\\"Buy\\"}",Text2:"{\\"text\\":\\"x' + str(buyamount) + '\\"}",Text4:"{\\"text\\":\\"$' + f'{price_buy:,}' + '\\"}"}')
            if 'sell' in entry:
                groupCommandText[group][name]['sell'] = []
                groupCommandText[group][name]['sell-sign'] = []
                for sellamount in entry['sell'] if type(entry['sell']) is list else (entry['sell'],):
                    nbt_sell = 'id:"minecraft:' + name + ('"' if sellamount == 1 else '",Count:' + str(sellamount) + 'b')
                    clear_sell = name + ' ' + str(sellamount)
                    score_sell = name + ('_sell' if sellamount == 1 else '_sell_' + str(sellamount))
                    assert score_sell in scoreboardNames
                    price_sell = scoreboardNames[score_sell]
                    groupCommandText[group][name]['sell'].append(spacer_sell[0] + nbt_sell + spacer_sell[1] + nbt_sell + spacer_sell[2] + clear_sell + spacer_sell[3] + score_sell + spacer_sell[4])
                    groupCommandText[group][name]['sell-sign'].append('{Text1:"{\\"text\\":\\"Sell\\"}",Text2:"{\\"text\\":\\"x' + str(sellamount) + '\\"}",Text4:"{\\"text\\":\\"$' + f'{price_sell:,}' + '\\"}"}')
            groupCommandText[group][name]['sign'] = '{Text1:"{\\"text\\":\\"' + name.replace('_',  ' ').title() + '\\",\\"color\\":\\"white\\"}"}'
    return groupCommandText

# convert command text into single command
def groupCommands(groupCommandText):
    import SingleCommandGenerator
    groupCommandSingle = {}
    for group, collection in groupCommandText.items():
        groupCommandSingle[group] = {}
        for name, entry in collection.items():
            groupCommandSingle[group][name] = {}
            for key, commandText in entry.items():
                if key == 'buy' or key == 'sell':
                    groupCommandSingle[group][name][key] = []
                    for command in commandText:
                        groupCommandSingle[group][name][key].append(SingleCommandGenerator.parse(command.split('\n'), outfile=False))
                else:
                    groupCommandSingle[group][name][key] = commandText
    return groupCommandSingle

def convertCommands(groupCommandSingle, sign = True, buy = True, sell = True, override = False, spacer = False, direction = 'positive-x', collect = [3], filterGroup = lambda x: True):
    import SingleCommandGenerator
    singleCommands = []
    new_commandlist = lambda: ['#@ ' + direction, '#@ skip 1', '#@ default impulse']
    dir_sign = 1 if direction[0:8] == 'positive' else -1
    get_signcommand = (lambda index: 'summon falling_block ~' + str(index*dir_sign) + ' ~' + str(index+10) + ' ~') if direction[9] == 'x' else (lambda index: 'summon falling_block ~ ~' + str(index+10) + ' ~' + str(index*dir_sign))
    for group, collection in groupCommandSingle.items():
        if not filterGroup(group):
            continue
        singleCommands.append('# ' + group + (' buy,' if buy else '') + (' sell,' if sell else '') + ' | ' + direction)
        count = 0
        commandlist = new_commandlist()
        for name, entry in collection.items():
            if sign:
                signcommand = ['#@ remove+']
                index = 0
                present = override or (not buy and not sell)
                if buy and 'buy-sign' in entry:
                    present = True
                    for data in entry['buy-sign']:
                        index += 1
                        signcommand.append(get_signcommand(index) + ' {Time:1,BlockState:{Name:"birch_sign"},TileEntityData:' + data + '}')
                if sell and 'sell-sign' in entry:
                    present = True
                    for data in entry['sell-sign']:
                        index += 1
                        signcommand.append(get_signcommand(index) + ' {Time:1,BlockState:{Name:"birch_sign"},TileEntityData:' + data + '}')
                if present:
                    if 'sign' in entry:
                        index += 1
                        signcommand.append(get_signcommand(index) + ' {Time:1,BlockState:{Name:"warped_sign"},TileEntityData:' + entry['sign'] + '}')
                    commandlist.append(SingleCommandGenerator.parse(signcommand, outfile=False))
            present = override
            if buy and 'buy' in entry:
                present = True
                for command in entry['buy']:
                    commandlist.append(command)
            if sell and 'sell' in entry:
                present = True
                for command in entry['sell']:
                    commandlist.append(command)
            if present:
                commandlist.append('summon armor_stand ~ ~ ~ {Invisible:1,Invulnerable:1,NoGravity:1,Small:1,DisabledSlots:16191,CustomNameVisible:1,CustomName:"{\\"text\\":\\"' + name + '\\"}",ArmorItems:[{},{},{},{id:' + name + ',Count:1b}],Tags:["command_shop","' + group + '"]}')
                count += 1
            elif sign and index > 0:
                count += 1
            if count == collect[0]:
                singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
                commandlist = new_commandlist()
                count = 0
                collect.append(collect.pop(0))
            elif spacer:
                commandlist.append('/')
        if count != 0:
            singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return singleCommands

def countshops(groupindex):
    count = 0
    for group, entry in groupindex.items():
        buy, sell = 0, 0
        for key, value in entry.items():
            if 'buy' in value:
                buy += 1
            if 'sell' in value:
                sell += 1
        total = buy + sell
        count += total
        print(group, buy, sell, total)
    return count

#block 15 28 43     [2,2,2,2,3,2,  2,  3,2,2,2,2,2]
#item 32 32 64      [2,2,2,2,2,3,  1,2,2,2,2,2,2,1,2,1,1,1]
#food 29 39 68      [3,2,2,2,2,2,  1,2,2,2,2,2,2,1,1,1,  3,2,3,2]
#log 8 8 16         [3,1]
#ore 10 10 20       [1,2,1,2,3,1]
#misc 10 13 23      [2,2,2,2,2,1,1,1]
#total 234


if __name__ == '__main__':
    #rawindex = getItemName()
    #groupindex = groupItems(rawindex)
    #writeItemIndex(groupindex)
    groupindex = readItemIndex()
    scoreboardCommands, scoreboardNames = convertScoreboard(groupindex)
    #print('\n'.join(scoreboardCommands))
    scoreboardSingle = singleScoreboard(scoreboardCommands)
    #for item in scoreboardSingle: print(item);
    command_block_direction, group_collect, filterGroup = 'negative-z', [2,2,2,2,3,2,  2,  3,2,2,2,2,2], lambda x: x == 'block'
    groupCommandText = createCommands(groupindex, scoreboardNames, button_dir = command_block_direction)
    #print(json.dumps(groupCommandText, indent=2))
    groupCommandSingle = groupCommands(groupCommandText)
    #print(json.dumps(groupCommandSingle, indent=2))
    singleCommands = convertCommands(groupCommandSingle, sign = True, buy = False, sell = True, override = False, direction = command_block_direction, collect = group_collect, filterGroup = filterGroup)
    for item in singleCommands: print(item);
    #print('total', countshops(groupindex))
    
