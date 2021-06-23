# random box

# single target
summon armor_stand ~ ~1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_target"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"?\"}"}
# many randomizer
summon armor_stand ~ ~-1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_randomizer"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"box\"}"}
# random-selector
execute at @e[type=armor_stand,tag=box_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~1 ~ ~ redstone_block
# action
execute at @e[type=armor_stand,tag=box_target,sort=nearest,limit=1] if block ~ ~ ~ trapped_chest run data modify block ~ ~ ~ LootTable set value "minecraft:chests/spawn_bonus_chest"
# clean-up
execute at @e[type=armor_stand,tag=box_randomizer,limit=40] if block ~ ~ ~ command_block if block ~1 ~ ~ redstone_block run setblock ~1 ~ ~ air
#fill ~ ~ ~ ~1 ~1 ~1 air
#execute if block ~ ~-3 ~ redstone_block at @e[type=armor_stand,tag=box_randomizer,limit=40] if block ~ ~ ~ command_block if block ~1 ~ ~ redstone_block run setblock ~1 ~ ~ air
#execute if block ~ ~-2 ~ redstone_block run setblock ~ ~-2 ~ air

# transaction
# price same as netherite sell price.
scoreboard players set random_box_buy Price 50000
#@ keep
#@ impulse
#@ manual
execute at @p[distance=..3] if score @p[distance=0] Wallet < random_box_buy Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
#@ manual
execute at @p[distance=..3] unless block ~ ~-5 ~1 redstone_block unless entity @a[scores={Transaction=151}] if score @p[distance=0] Wallet >= random_box_buy Price run scoreboard players set @p[distance=0,scores={Transaction=0}] Transaction 151
#@ conditional
execute if entity @p[scores={Transaction=151}] run setblock ~ ~-4 ~1 redstone_block
#@ conditional
scoreboard players operation @p[scores={Transaction=151}] Wallet -= random_box_buy Price
#@ conditional
tellraw @p[scores={Transaction=151}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=151}] Transaction 0



# random book

# many randomizer
summon armor_stand ~ ~-1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","book_randomizer"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"book\"}"}
# random-selector
execute at @e[type=armor_stand,tag=book_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~-1 ~ ~ redstone_block
# action
give @p[scores={Transaction=152}] enchanted_book{StoredEnchantments:[{lvl:1,id:mending}]}
# clean-up
execute at @e[type=armor_stand,tag=book_randomizer,limit=110] if block ~ ~ ~ command_block if block ~-1 ~ ~ redstone_block run setblock ~-1 ~ ~ air

# transaction
# price same as random box price?
scoreboard players set random_book_buy Price 50000
#@ keep
#@ impulse
#@ manual
execute at @p[distance=..3] if score @p[distance=0] Wallet < random_book_buy Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute at @p[distance=..3] unless entity @a[scores={Transaction=152}] if score @p[distance=0] Wallet >= random_book_buy Price run scoreboard players set @p[distance=0,scores={Transaction=0}] Transaction 152
#@ conditional
execute if entity @p[scores={Transaction=152}] run execute at @e[type=armor_stand,tag=book_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~-1 ~ ~ redstone_block
#@ conditional
scoreboard players operation @p[scores={Transaction=152}] Wallet -= random_book_buy Price
#@ conditional
tellraw @p[scores={Transaction=152}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
execute if entity @p[scores={Transaction=152}] at @e[type=armor_stand,tag=book_randomizer,limit=110] if block ~ ~ ~ command_block if block ~-1 ~ ~ redstone_block run setblock ~-1 ~ ~ air
scoreboard players set @p[scores={Transaction=152}] Transaction 0
