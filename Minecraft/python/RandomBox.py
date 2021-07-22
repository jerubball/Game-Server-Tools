
def getLootTableCommand():
    LootTables =   ("minecraft:chests/abandoned_mineshaft",
                    "minecraft:chests/bastion_bridge",
                    "minecraft:chests/bastion_hoglin_stable",
                    "minecraft:chests/bastion_other",
                    "minecraft:chests/bastion_treasure",
                    "minecraft:chests/buried_treasure",
                    "minecraft:chests/desert_pyramid",
                    "minecraft:chests/end_city_treasure",
                    "minecraft:chests/igloo_chest",
                    "minecraft:chests/jungle_temple",
                    "minecraft:chests/nether_bridge",
                    "minecraft:chests/pillager_outpost",
                    "minecraft:chests/ruined_portal",
                    "minecraft:chests/shipwreck_map",
                    "minecraft:chests/shipwreck_supply",
                    "minecraft:chests/shipwreck_treasure",
                    "minecraft:chests/simple_dungeon",
                    "minecraft:chests/spawn_bonus_chest",
                    "minecraft:chests/stronghold_corridor",
                    "minecraft:chests/stronghold_crossing",
                    "minecraft:chests/stronghold_library",
                    "minecraft:chests/underwater_ruin_big",
                    "minecraft:chests/underwater_ruin_small",
                    "minecraft:chests/woodland_mansion",
                    "minecraft:chests/village/village_armorer",
                    "minecraft:chests/village/village_butcher",
                    "minecraft:chests/village/village_cartographer",
                    "minecraft:chests/village/village_mason",
                    "minecraft:chests/village/village_shepherd",
                    "minecraft:chests/village/village_tannery",
                    "minecraft:chests/village/village_weaponsmith",
                    "minecraft:chests/village/village_desert_house",
                    "minecraft:chests/village/village_plains_house",
                    "minecraft:chests/village/village_savanna_house",
                    "minecraft:chests/village/village_snowy_house",
                    "minecraft:chests/village/village_taiga_house",
                    "minecraft:chests/village/village_fisher",
                    "minecraft:chests/village/village_fletcher",
                    "minecraft:chests/village/village_temple",
                    "minecraft:chests/village/village_toolsmith") # len=40
    #print(len(LootTables))
    lootTableCommand = []
    for entry in LootTables:
        lootTableCommand.append('execute at @e[type=armor_stand,tag=box_target,sort=nearest,limit=1] if block ~ ~ ~ trapped_chest run data modify block ~ ~ ~ LootTable set value "' + entry + '"')
    return lootTableCommand

def getSingleCommand(lootTableCommand, size=8, direction='negative-z'):
    #summon minecraft:armor_stand ~ ~1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_target"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"?\"}"}
    #execute at @e[type=minecraft:armor_stand,tag=box_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~1 ~ ~ redstone_block
    import SingleCommandGenerator
    armorStandCommand = ['#@ remove+', '#@ ' + direction, '#@ default impulse']
    armorStand = 'summon minecraft:armor_stand ~ ~-1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_randomizer"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\\"text\\":\\"box\\"}"}'
    for i in range(size):
        armorStandCommand.append(armorStand)
    armorStandSingle = SingleCommandGenerator.parse(armorStandCommand, outfile=False)
    def new_commandlist():
        return ['#@ ' + direction, '#@ skip 1', '#@ default impulse', '#@ default manual', '#@ auto', armorStandSingle]
    singleCommands = []
    commandlist = new_commandlist()
    count = 0
    for command in lootTableCommand:
        commandlist.append(command)
        count += 1
        if count == size:
            singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
            commandlist = new_commandlist()
            count = 0
    return singleCommands

def getEnchantbookCommand():
    enchantments = {"aqua_affinity": [1],               #
                    "bane_of_arthropods": [1,2,3,4,5],  #
                    "binding_curse": [1],
                    "blast_protection": [1,2,3,4],      #
                    "channeling": [1],                  #
                    "depth_strider": [1,2,3],           #
                    "efficiency": [1,2,3,4,5],          # ****
                    "feather_falling": [1,2,3,4],       #
                    "fire_aspect": [1,2],               # *
                    "fire_protection": [1,2,3,4],       #
                    "flame": [1],                       # *
                    "fortune": [1,2,3],                 # ***
                    "frost_walker": [1,2],              #
                    "impaling": [1,2,3,4,5],            #
                    "infinity": [1],                    # **
                    "knockback": [1,2],                 #
                    "looting": [1,2,3],                 # ***
                    "loyalty": [1,2,3],                 #
                    "luck_of_the_sea": [1,2,3],         #
                    "lure": [1,2,3],                    #
                    "mending": [1],                     # *****
                    "multishot": [1],                   #
                    "piercing": [1,2,3,4],              #
                    "power": [1,2,3,4,5],               # **
                    "projectile_protection": [1,2,3,4], #
                    "protection": [1,2,3,4],            # ****
                    "punch": [1,2],                     #
                    "quick_charge": [1,2,3],            #
                    "respiration": [1,2,3],             #
                    "riptide": [1,2,3],                 #
                    "sharpness": [1,2,3,4,5],           # ****
                    "silk_touch": [1],                  # **
                    "smite": [1,2,3,4,5],               #
                    "soul_speed": [1,2,3],              #
                    "sweeping": [1,2,3],                # *
                    "thorns": [1,2,3],                  # **
                    "unbreaking": [1,2,3],              # *****
                    "vanishing_curse": [1]} # total=110
    enchantmentCommand = []
    for key, levels in enchantments.items():
        for level in levels:
            enchantmentCommand.append('give @p[scores={Transaction=152}] enchanted_book{StoredEnchantments:[{lvl:' + str(level) + ',id:' + key + '}]}')
    return enchantmentCommand

def getSingleCommand2(enchantmentCommand, size=11, direction='negative-z'):
    #execute at @e[type=minecraft:armor_stand,tag=book_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~1 ~ ~ redstone_block
    import SingleCommandGenerator
    armorStandCommand = ['#@ remove+', '#@ ' + direction, '#@ default impulse']
    armorStand = 'summon minecraft:armor_stand ~ ~-1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","book_randomizer"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\\"text\\":\\"book\\"}"}'
    for i in range(size):
        armorStandCommand.append(armorStand)
    armorStandSingle = SingleCommandGenerator.parse(armorStandCommand, outfile=False)
    def new_commandlist():
        return ['#@ ' + direction, '#@ skip 1', '#@ default impulse', '#@ default manual', '#@ auto', armorStandSingle]
    singleCommands = []
    commandlist = new_commandlist()
    count = 0
    for command in enchantmentCommand:
        commandlist.append(command)
        count += 1
        if count == size:
            singleCommands.append(SingleCommandGenerator.parse(commandlist, outfile=False))
            commandlist = new_commandlist()
            count = 0
    return singleCommands

if __name__ == '__main__':
    lootTableCommand = getLootTableCommand()
    singleCommands = getSingleCommand(lootTableCommand)
    #for item in singleCommands: print(item);
    enchantmentCommand = getEnchantbookCommand()
    singleCommands2 = getSingleCommand2(enchantmentCommand)
    for item in singleCommands2: print(item);
