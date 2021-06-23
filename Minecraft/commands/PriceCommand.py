
# generate shop command for balance trade
def generateCommand(start=6, stop=28, jump=2):
    import SingleCommandGenerator
    #           0           1           2           3           4           5           6           7           8
    amount =   (1,          2,          5,          10,         20,         50,         100,        200,        500,        None, # 0
                1000,       2000,       5000,       10000,      20000,      50000,      100000,     200000,     500000,     None, # 10
                1000000,    2000000,    5000000,    10000000,   20000000,   50000000,   100000000,  200000000,  500000000,  None, # 20
                1000000000, 2000000000)
    spacer_withdraw = ('''#@ keep
#@ impulse
#@ manual
tellraw @p[distance=0..3,scores={Wallet=..''', '''}] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute unless entity @a[scores={Transaction=101}] run scoreboard players set @p[distance=0..3,scores={Transaction=0,Wallet=''', '''..}] Transaction 101
#@ conditional
scoreboard players remove @p[scores={Transaction=101}] Wallet ''', '''
#@ conditional
give @p[scores={Transaction=101}] paper{HideFlags:1,display:{Name:"{\\"text\\":\\"Money Order\\"}",Lore:["{\\"text\\":\\"$''', ''' bill\\"}","{\\"text\\":\\"Value must never change\\"}","{\\"text\\":\\"Can be renamed\\"}","{\\"text\\":\\"Void if disenchanted\\"}"]},Enchantments:[{id:binding_curse,lvl:''', '''}]}
#@ conditional
tellraw @p[scores={Transaction=101}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=101}] Transaction 0''') # len=6
    spacer_deposit = ('''#@ keep
#@ impulse
#@ manual
execute unless entity @p[distance=..3,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] run tellraw @p[distance=0..3] [{"text":"You do not have this item","color":"red"}]
execute unless entity @a[scores={Transaction=102}] run scoreboard players set @p[distance=0..3,scores={Transaction=0},nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:''', '''}]}}]}] Transaction 102
#@ conditional
clear @p[scores={Transaction=102}] paper{Enchantments:[{id:binding_curse,lvl:''', '''}]} 1
#@ conditional
scoreboard players add @p[scores={Transaction=102}] Wallet ''', '''
#@ conditional
tellraw @p[scores={Transaction=102}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=102}] Transaction 0''') # len=5
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
    def new_commandlist():
        return ['#@ negative-z', '#@ skip 1', '#@ default impulse']
    commandfinal = []
    for key, commands in commandsingle.items():
        commandfinal.append('# ' + key)
        count = 0
        commandlist = new_commandlist()
        for command in commands:
            commandlist.append(command)
            count += 1
            if count == 8:
                commandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
                commandlist = new_commandlist()
                count = 0
        if count != 0:
            commandfinal.append(SingleCommandGenerator.parse(commandlist, outfile=False))
    return commandfinal


if __name__ == '__main__':
    commandfinal = generateCommand()
    for item in commandfinal: print(item);
