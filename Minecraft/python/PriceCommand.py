
# generate shop command for balance trade
def generateCommand(start=6, stop=28, jump=2):
    import SingleCommandGenerator
    #           0           1           2           3           4           5           6           7           8
    amount =   (1,          2,          5,          10,         20,         50,         100,        200,        500,        None, # 0
                1000,       2000,       5000,       10000,      20000,      50000,      100000,     200000,     500000,     None, # 10
                1000000,    2000000,    5000000,    10000000,   20000000,   50000000,   100000000,  200000000,  500000000,  None, # 20
                1000000000, 2000000000)
    spacer_withdraw = ('''#@ keep
#@ repeat
#@ manual
execute if block ~1 ~1 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] run tellraw @p[distance=0,scores={Wallet=..''', '''}] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~1 ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=103}] run scoreboard players set @p[distance=0,scores={Wallet=''', '''..}] Transaction 103
#@ conditional
execute if block ~1 ~3 ~ #buttons[powered=true] run scoreboard players remove @p[scores={Transaction=103}] Wallet ''', '''
#@ conditional
execute if block ~1 ~4 ~ #buttons[powered=true] run give @p[scores={Transaction=103}] paper{HideFlags:1,display:{Name:"{\\"text\\":\\"Money Order\\"}",Lore:["{\\"text\\":\\"$''', '''\\"}","{\\"text\\":\\"Value must never change\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}
#@ conditional
execute if block ~1 ~5 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=103}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~1 ~6 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=103}] Transaction 0
execute if block ~1 ~7 ~ #buttons[powered=true] run setblock ~1 ~7 ~ stone_button[powered=false,face=wall,facing=east]''') # len=6
    spacer_deposit = ('''#@ keep
#@ repeat
#@ manual
execute if block ~1 ~1 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run tellraw @p[distance=0..3] [{"text":"You do not have this item","color":"red"}]
execute if block ~1 ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=104}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] Transaction 104
#@ conditional
execute if block ~1 ~3 ~ #buttons[powered=true] run clear @p[scores={Transaction=104}] paper{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]} 1
#@ conditional
execute if block ~1 ~4 ~ #buttons[powered=true] run scoreboard players add @p[scores={Transaction=104}] Wallet ''', '''
#@ conditional
execute if block ~1 ~5 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=104}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~1 ~6 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=104}] Transaction 0
execute if block ~1 ~7 ~ #buttons[powered=true] run setblock ~1 ~7 ~ stone_button[powered=false,face=wall,facing=east]''') # len=5
    commandset = {'withdraw': [], 'deposit': []}
    index = start
    while index <= stop:
        cost = amount[index]
        commandset['withdraw'].append(spacer_withdraw[0] + str(cost-1) + spacer_withdraw[1] + str(cost) + spacer_withdraw[2] + str(cost) + spacer_withdraw[3] + f'{cost:,}' + spacer_withdraw[4] + str(index) + spacer_withdraw[5])
        commandset['deposit'].append(spacer_deposit[0] + str(index) + spacer_deposit[1] + str(index) + spacer_deposit[2] + str(index) + spacer_deposit[3] + str(cost) + spacer_deposit[4])
        step = jump
        while step > 0:
            index += 1
            if amount[index] is not None:
                step -= 1
    commandsingle = {}
    for key, commands in commandset.items():
        commandsingle[key] = []
        for command in commands:
            commandsingle[key].append(SingleCommandGenerator.parse(command.split('\n'), outfile=False))
    new_commandlist = lambda: ['#@ negative-z', '#@ skip 1', '#@ default impulse']
    commandfinal = []
    for key, commands in commandsingle.items():
        commandfinal.append('# ' + key)
        count = 0
        commandlist = new_commandlist()
        for command in commands:
            commandlist.append(command)
            count += 1
            if count == 6:
                commandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
                commandlist = new_commandlist()
                count = 0
        if count != 0:
            commandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return commandsingle, commandfinal

def generateFunction(start=6, stop=28, jump=2):
    import SingleCommandGenerator
    #           0           1           2           3           4           5           6           7           8
    amount =   (1,          2,          5,          10,         20,         50,         100,        200,        500,        None, # 0
                1000,       2000,       5000,       10000,      20000,      50000,      100000,     200000,     500000,     None, # 10
                1000000,    2000000,    5000000,    10000000,   20000000,   50000000,   100000000,  200000000,  500000000,  None, # 20
                1000000000, 2000000000)
    commandblockinput = '''execute if block ~1 ~1 ~ #buttons[powered=true] run function jerubball:'''
    functionwrapper = ('''execute as @p[gamemode=!spectator,distance=..3,scores={Transaction=0}] run function jerubball:''','''
setblock ~1 ~1 ~ stone_button[powered=false,face=wall,facing=east]
''')
    spacer_withdraw = ('''execute unless score @s Wallet matches ''', '''.. run tellraw @s [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute unless entity @a[scores={Transaction=107}] if score @s Wallet matches ''', '''.. run scoreboard players set @s Transaction 107
execute if score @s Transaction matches 107 run scoreboard players remove @s Wallet ''', '''
execute if score @s Transaction matches 107 run give @s paper{HideFlags:1,display:{Name:"{\\"text\\":\\"Money Order\\"}",Lore:["{\\"text\\":\\"$''', '''\\"}","{\\"text\\":\\"Value must never change\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}
execute if score @s Transaction matches 107 run tellraw @s [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if score @s Transaction matches 107 run scoreboard players set @s Transaction 0
''') #len=6
    spacer_deposit = ('''execute unless entity @s[nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run tellraw @s [{"text":"You do not have this item","color":"red"}]
execute unless entity @a[scores={Transaction=108}] if entity @s[nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run scoreboard players set @s Transaction 108
execute if score @s Transaction matches 108 run clear @s paper{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]} 1
execute if score @s Transaction matches 108 run scoreboard players add @s Wallet ''', '''
execute if score @s Transaction matches 108 run tellraw @s [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if score @s Transaction matches 108 run scoreboard players set @s Transaction 0
''') #len=5
    commandset = {'withdraw': {}, 'deposit': {}}
    commandblockset = {'withdraw': [], 'deposit': []}
    index = start
    while index <= stop:
        cost = amount[index]
        commandset['withdraw'][cost] = spacer_withdraw[0] + str(cost) + spacer_withdraw[1] + str(cost) + spacer_withdraw[2] + str(cost) + spacer_withdraw[3] + f'{cost:,}' + spacer_withdraw[4] + str(index) + spacer_withdraw[5]
        commandset['deposit'][cost] = spacer_deposit[0] + str(index) + spacer_deposit[1] + str(index) + spacer_deposit[2] + str(index) + spacer_deposit[3] + str(cost) + spacer_deposit[4]
        step = jump
        while step > 0:
            index += 1
            if amount[index] is not None:
                step -= 1
    for key, commands in commandset.items():
        for cost, command in commands.items():
            filename = 'money/'+key+'_'+str(cost)
            with open('./'+filename+'.mcfunction', mode='w') as file:
                file.write(command)
            with open('./'+filename+'_wrapper.mcfunction', mode='w') as file:
                file.write(functionwrapper[0] + filename + functionwrapper[1])
            commandblockset[key].append(commandblockinput + filename + '_wrapper')
    new_commandlist = lambda: ['#@ negative-z', '#@ skip 1', '#@ default repeat', '#@ default manual', '#@ default down']
    funccommandfinal = []
    for key, commands in commandblockset.items():
        funccommandfinal.append('# ' + key)
        commandlist = new_commandlist()
        commandlist.extend(commands)
        funccommandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return funccommandfinal

def generateXpCommand():
    import SingleCommandGenerator
    amount = {2: 16, 6: 72, 14: 280, 27: 1089}
    spacer_store = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~1 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] run tellraw @p[distance=0,level=..''', '''] [{"text":"Not enough xp. Your level is: ","color":"red"},{"entity":"@p[distance=0]","nbt":"XpLevel"}]
execute if block ~ ~2 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=105}] run scoreboard players set @p[distance=0,level=''', '''..] Transaction 105
#@ conditional
execute if block ~ ~3 ~-1 #buttons[powered=true] run xp add @p[scores={Transaction=105}] ''', '''
#@ conditional
execute if block ~ ~4 ~-1 #buttons[powered=true] run give @p[scores={Transaction=105}] paper{HideFlags:1,display:{Name:"{\\"text\\":\\"XP Receipt\\"}",Lore:["{\\"text\\":\\"''', ''' xp points\\"}","{\\"text\\":\\"Raises level from 0 to ''', '''\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}
#@ conditional
execute if block ~ ~5 ~-1 #buttons[powered=true] run tellraw @p[scores={Transaction=105}] [{"text":"Your new level is: ","color":"yellow"},{"entity":"@p[scores={Transaction=105}]","nbt":"XpLevel"}]
execute if block ~ ~6 ~-1 #buttons[powered=true] run scoreboard players set @p[scores={Transaction=105}] Transaction 0
execute if block ~ ~7 ~-1 #buttons[powered=true] run setblock ~ ~7 ~-1 stone_button[powered=false,face=wall,facing=north]''') # len=7
    spacer_recall = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~1 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute if block ~ ~2 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=106}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] Transaction 106
#@ conditional
execute if block ~ ~3 ~-1 #buttons[powered=true] run clear @p[scores={Transaction=106}] paper{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]} 1
#@ conditional
execute if block ~ ~4 ~-1 #buttons[powered=true] run xp add @p[scores={Transaction=106}] ''', '''
#@ conditional
execute if block ~ ~5 ~-1 #buttons[powered=true] run tellraw @p[scores={Transaction=106}] [{"text":"Your new level is: ","color":"yellow"},{"entity":"@p[scores={Transaction=106}]","nbt":"XpLevel"}]
execute if block ~ ~6 ~-1 #buttons[powered=true] run scoreboard players set @p[scores={Transaction=106}] Transaction 0
execute if block ~ ~7 ~-1 #buttons[powered=true] run setblock ~ ~7 ~-1 stone_button[powered=false,face=wall,facing=north]''') # len=5
    commandset = {'store': [], 'recall': []}
    for level, point in amount.items():
        enchant = 100 + level
        commandset['store'].append(spacer_store[0] + str(level-1) + spacer_store[1] + str(level) + spacer_store[2] + str(-point) + spacer_store[3] + str(point) + spacer_store[4] + str(level) + spacer_store[5] + str(enchant) + spacer_store[6])
        commandset['recall'].append(spacer_recall[0] + str(enchant) + spacer_recall[1] + str(enchant) + spacer_recall[2] + str(enchant) + spacer_recall[3] + str(point) + spacer_recall[4])
    commandsingle = {}
    for key, commands in commandset.items():
        commandsingle[key] = []
        for command in commands:
            commandsingle[key].append(SingleCommandGenerator.parse(command.split('\n'), outfile=False))
    new_commandlist = lambda: ['#@ negative-x', '#@ skip 1', '#@ default impulse']
    xpcommandfinal = []
    for key, commands in commandsingle.items():
        xpcommandfinal.append('# ' + key)
        commandlist = new_commandlist()
        commandlist.extend(commands)
        xpcommandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return xpcommandfinal

def generateXpFunction():
    import SingleCommandGenerator
    amount = {2: 16, 6: 72, 14: 280, 27: 1089, 46: 4267, 79: 17467}
    commandblockinput = '''execute if block ~ ~1 ~-1 #buttons[powered=true] run function jerubball:'''
    functionwrapper = ('''execute as @p[gamemode=!spectator,distance=..3,scores={Transaction=0}] run function jerubball:''','''
setblock ~ ~1 ~-1 stone_button[powered=false,face=wall,facing=north]
''')
    spacer_store = ('''execute unless entity @s[level=''', '''..] run tellraw @s [{"text":"Not enough xp. Your level is: ","color":"red"},{"entity":"@s","nbt":"XpLevel"}]
execute unless entity @a[scores={Transaction=109}] if entity @s[level=''', '''..] run scoreboard players set @s Transaction 109
execute if score @s Transaction matches 109 run xp add @s ''', '''
execute if score @s Transaction matches 109 run give @s paper{HideFlags:1,display:{Name:"{\\"text\\":\\"XP Receipt\\"}",Lore:["{\\"text\\":\\"''', ''' xp points\\"}","{\\"text\\":\\"Raises level from 0 to ''', '''\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}
execute if score @s Transaction matches 109 run tellraw @s [{"text":"Your new level is: ","color":"yellow"},{"entity":"@s","nbt":"XpLevel"}]
execute if score @s Transaction matches 109 run scoreboard players set @s Transaction 0
''') # len=7
    spacer_recall = ('''execute unless entity @s[nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run tellraw @s [{"text":"You do not have this item","color":"red"}]
execute unless entity @a[scores={Transaction=110}] if entity @s[nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]}}]}] run scoreboard players set @s Transaction 110
execute if score @s Transaction matches 110 run clear @s paper{Enchantments:[{id:"minecraft:binding_curse",lvl:''', '''s}]} 1
execute if score @s Transaction matches 110 run xp add @s ''', '''
execute if score @s Transaction matches 110 run tellraw @s [{"text":"Your new level is: ","color":"yellow"},{"entity":"@s","nbt":"XpLevel"}]
execute if score @s Transaction matches 110 run scoreboard players set @s Transaction 0
''') # len=5
    commandset = {'store': {}, 'recall': {}}
    commandblockset = {'store': [], 'recall': []}
    for level, point in amount.items():
        enchant = 100 + level
        commandset['store'][level] = spacer_store[0] + str(level) + spacer_store[1] + str(level) + spacer_store[2] + str(-point) + spacer_store[3] + str(point) + spacer_store[4] + str(level) + spacer_store[5] + str(enchant) + spacer_store[6]
        commandset['recall'][level] = spacer_recall[0] + str(enchant) + spacer_recall[1] + str(enchant) + spacer_recall[2] + str(enchant) + spacer_recall[3] + str(point) + spacer_recall[4]
    new_commandlist = lambda: ['#@ negative-x', '#@ skip 1', '#@ default repeat', '#@ default manual', '#@ default down']
    for key, commands in commandset.items():
        for level, command in commands.items():
            filename = 'exp/'+key+'_'+str(level)
            with open('./'+filename+'.mcfunction', mode='w') as file:
                file.write(command)
            with open('./'+filename+'_wrapper.mcfunction', mode='w') as file:
                file.write(functionwrapper[0] + filename + functionwrapper[1])
            commandblockset[key].append(commandblockinput + filename + '_wrapper')
    new_commandlist = lambda: ['#@ negative-x', '#@ skip 1', '#@ default repeat', '#@ default manual', '#@ default down']
    funccommandfinal = []
    for key, commands in commandblockset.items():
        funccommandfinal.append('# ' + key)
        commandlist = new_commandlist()
        commandlist.extend(commands)
        funccommandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return funccommandfinal


if __name__ == '__main__':
    #commandsingle, commandfinal = generateCommand()
    #for item in commandfinal: print(item);
    #xpcommandfinal = generateXpCommand()
    #for item in xpcommandfinal: print(item);
    #commandblockset = generateFunction()
    #for item in commandblockset: print(item);
    xpfunctionfinal = generateXpFunction()
    for item in xpfunctionfinal: print(item);
