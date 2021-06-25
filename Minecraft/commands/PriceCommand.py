
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
execute if block ~1 ~4 ~ #buttons[powered=true] run give @p[scores={Transaction=103}] paper{HideFlags:1,display:{Name:"{\\"text\\":\\"Money Order\\"}",Lore:["{\\"text\\":\\"$''', '''\\"}","{\\"text\\":\\"Value must never change\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:binding_curse,lvl:''', '''}]}
#@ conditional
execute if block ~1 ~5 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=103}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~1 ~6 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=103}] Transaction 0
execute if block ~1 ~7 ~ #buttons[powered=true] run setblock ~1 ~7 ~ stone_button[powered=false,face=wall,facing=east]''') # len=6
    spacer_deposit = ('''#@ keep
#@ repeat
#@ manual
execute if block ~1 ~1 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] run tellraw @p[distance=0..3] [{"text":"You do not have this item","color":"red"}]
execute if block ~1 ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=104}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] Transaction 104
#@ conditional
execute if block ~1 ~3 ~ #buttons[powered=true] run clear @p[scores={Transaction=104}] paper{Enchantments:[{id:binding_curse,lvl:''', '''}]} 1
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
    return commandfinal

def generateXpCommand():
    import SingleCommandGenerator
    amount = {2: 16, 6: 72, 14: 280, 27: 1089}
    sapcer_store = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~1 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] run tellraw @p[distance=0,level=..''', '''] [{"text":"Not enough xp. Your level is: ","color":"red"},{"entity":"@p[distance=0]","nbt":"XpLevel"}]
execute if block ~ ~2 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=105}] run scoreboard players set @p[distance=0,level=''', '''..] Transaction 105
#@ conditional
execute if block ~ ~3 ~-1 #buttons[powered=true] run xp add @p[scores={Transaction=105}] ''', '''
#@ conditional
execute if block ~ ~4 ~-1 #buttons[powered=true] run give @p[scores={Transaction=105}] paper{HideFlags:1,display:{Name:"{\\"text\\":\\"XP Receipt\\"}",Lore:["{\\"text\\":\\"''', ''' xp points\\"}","{\\"text\\":\\"Raises level from 0 to ''', '''\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:binding_curse,lvl:''', '''}]}
#@ conditional
execute if block ~ ~5 ~-1 #buttons[powered=true] run tellraw @p[scores={Transaction=105}] [{"text":"Your new level is: ","color":"yellow"},{"entity":"@p[scores={Transaction=105}]","nbt":"XpLevel"}]
execute if block ~ ~6 ~-1 #buttons[powered=true] run scoreboard players set @p[scores={Transaction=105}] Transaction 0
execute if block ~ ~7 ~-1 #buttons[powered=true] run setblock ~ ~7 ~-1 stone_button[powered=false,face=wall,facing=north]''') # len=7
    spacer_recall = ('''#@ keep
#@ repeat
#@ manual
execute if block ~ ~1 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute if block ~ ~2 ~-1 #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=106}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] Transaction 106
#@ conditional
execute if block ~ ~3 ~-1 #buttons[powered=true] run clear @p[scores={Transaction=106}] paper{Enchantments:[{id:binding_curse,lvl:''', '''}]} 1
#@ conditional
execute if block ~ ~4 ~-1 #buttons[powered=true] run xp add @p[scores={Transaction=106}] ''', '''
#@ conditional
execute if block ~ ~5 ~-1 #buttons[powered=true] run tellraw @p[scores={Transaction=106}] [{"text":"Your new level is: ","color":"yellow"},{"entity":"@p[scores={Transaction=106}]","nbt":"XpLevel"}]
execute if block ~ ~6 ~-1 #buttons[powered=true] run scoreboard players set @p[scores={Transaction=106}] Transaction 0
execute if block ~ ~7 ~-1 #buttons[powered=true] run setblock ~ ~7 ~-1 stone_button[powered=false,face=wall,facing=north]''') # len=5
    commandset = {'store': [], 'recall': []}
    for level, point in amount.items():
        enchant = 100 + level
        commandset['store'].append(sapcer_store[0] + str(level-1) + sapcer_store[1] + str(level) + sapcer_store[2] + str(-point) + sapcer_store[3] + str(point) + sapcer_store[4] + str(level) + sapcer_store[5] + str(enchant) + sapcer_store[6])
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


if __name__ == '__main__':
    commandfinal = generateCommand()
    for item in commandfinal: print(item);
    xpcommandfinal = generateXpCommand()
    for item in xpcommandfinal: print(item);
