import json

def getItemName(infilename='baseworth.yml', outfilename='amount.json'):
    output = {}
    with open(infilename) as worth:
        for line in worth:
            line = line.strip()
            if len(line) > 0 and line[0] != '#':
                parts = line.split(':')
                if len(parts) == 2:
                    output[parts[0].lower()] = {'buy': 16, 'sell': 64, 'price' : float(parts[1])}
    with open(outfilename, mode='w') as file:
        json.dump(output, file, indent=2)
    return output

def getItemAmount(infilename='amount.json'):
    with open(infilename) as file:
        return json.load(file)

def convertScoreboard(amounts, adjust=10.0, multiplier=2):
    output = []
    for name, entry in amounts.items():
        price = round(entry['price'] * adjust)
        if 'buy' in entry and entry['buy'] > 0:
            if entry['buy'] == 1:
                output.append('scoreboard players set ' + name + '_buy Price ' + str(price * multiplier))
            else:
                output.append('scoreboard players set ' + name + '_buy_' + str(entry['buy']) + ' Price ' + str(price * multiplier * entry['buy']))
        if 'sell' in entry and entry['sell'] > 0:
            if entry['sell'] == 1:
                output.append('scoreboard players set ' + name + '_sell Price ' + str(price))
            else:
                output.append('scoreboard players set ' + name + '_sell_' + str(entry['sell']) + ' Price ' + str(price * entry['sell']))
    return output

def createCommands(amounts):
    output = {}
    spacer_buy = ['''#@ keep
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
scoreboard players set @p[scores={Transaction=3}] Transaction 0'''] # len=5
    spacer_sell = ['''#@ keep
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
scoreboard players set @p[scores={Transaction=4}] Transaction 0'''] # len=5
    for name, entry in amounts.items():
        score_buy = name + ('_buy' if entry['buy'] == 1 else '_buy_' + str(entry['buy']))
        give_buy = name if entry['buy'] == 1 else name + ' ' + str(entry['buy'])
        nbt_sell = 'id:"minecraft:' + name + ('"' if entry['sell'] == 1 else '",Count:' + str(entry['sell']) + 'b')
        clear_sell = name + ' ' + str(entry['sell'])
        score_sell = name + ('_sell' if entry['sell'] == 1 else '_sell_' + str(entry['sell']))
        output[name] = {'buy': spacer_buy[0] + score_buy + spacer_buy[1] + score_buy + spacer_buy[2] + score_buy + spacer_buy[3] + give_buy + spacer_buy[4],
                        'sell': spacer_sell[0] + nbt_sell + spacer_sell[1] + nbt_sell + spacer_sell[2] + clear_sell + spacer_sell[3] + score_sell + spacer_sell[4]}
    return output

def singleCommands(commands):
    import SingleCommandGenerator
    output = {}
    for name, entry in commands.items():
        output[name] = {'buy': SingleCommandGenerator.parse(entry['buy'].split('\n'), outfile=False),
                        'sell': SingleCommandGenerator.parse(entry['sell'].split('\n'), outfile=False)}
    return output

def printEntry(collection):
    output = []
    for name, entry in collection.items():
        output.append('#' + name)
        for command in entry.values():
            output.append(command)
    print('\n'.join(output))
    #print(json.dumps(output, indent=2))
    #print(output)
    #return output
    return

def collectItems(commands):
    output = {'block': [], 'dye': [], 'food': [], 'item': [], 'log': [], 'ore': [], 'misc': []}
    for name in commands:
        if '_dye' in name:
            output['dye'].append(name)
        elif 'cooked_' in name or '_seed' in name or '_bean' in name or '_mushroom' in name or '_fungus' in name or 'melon' in name or 'sugar' in name or 'sweet' in name or 'fish' in name or \
                name in ['cod', 'apple', 'bamboo', 'beetroot', 'beef', 'chicken', 'mutton', 'porkchop', 'bread', 'cactus', 'carrot', 'potato', 'pumpkin', 'rabbit', 'salmon', 'chorus_fruit', \
                         'egg', 'nether_wart', 'honey_bottle', 'honeycomb', 'wheat']:
            output['food'].append(name)
        elif '_log' in name or '_stem' in name:
            output['log'].append(name)
        elif ('block' in name and 'grass' not in name) or '_ingot' in name or 'redstone' in name or 'lapis' in name or name in ['ancient_debris', 'emerald', 'diamond', 'coal']:
            output['ore'].append(name)
        elif 'stone' in name or 'sand' in name or 'deepslate' in name or 'obsidian' in name or \
                name in ['andesite', 'basalt', 'diorite', 'dirt', 'gravel', 'netherrack', 'ice', 'grass_block', 'quartz', 'sponge', 'shroomlight']:
            output['block'].append(name)
        elif 'horse' in name or 'prismarine_' in name or 'ball' in name or \
                name in ['arrow', 'blaze_rod', 'bone', 'string', 'feather', 'flint', 'rabbit_foot', 'leather', 'rotten_flesh', 'ghast_tear', 'gunpowder', 'saddle', 'spider_eye', 'ender_pearl', \
                         'lead', 'ink_sac', 'phantom_membrane', 'nether_star', 'name_tag', 'scute', 'turtle_egg']:
            output['item'].append(name)
        else:
            output['misc'].append(name)
    #for category, items in output.items():
    #    print(category, ':', items)
    return output

def collectCommands(commands, collect):
    output = {}
    for key, collection in collect.items():
        output[key] = {}
        for item in collection:
            output[key][item] = commands[item]
    return output

def convertCommands(collected):
    import SingleCommandGenerator
    output = []
    def new_commandlist():
        return ['#@ positive-x', '#@ skip 2']
    for group, collection in collected.items():
        count = 0
        commandlist = new_commandlist()
        for key, command in collection.items():
            commandlist.append(command['buy'])
            commandlist.append(command['sell'])
            count += 1
            if count == 5:
                output.append(SingleCommandGenerator.parse(commandlist, outfile=False))
                commandlist = new_commandlist()
                count = 0
        if count != 0:
            output.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return output


if __name__ == '__main__':
    #getItemName()
    amounts = getItemAmount()
    #amounts = {"obsidian": {"buy": 16, "sell": 64, "price": 955.0}}
    output1 = convertScoreboard(amounts)
    #print('\n'.join(output1))
    output2 = createCommands(amounts)
    output3 = singleCommands(output2)
    collection = collectItems(amounts)
    output4 = collectCommands(output3, collection)
    output5 = convertCommands(output4)
