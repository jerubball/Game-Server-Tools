
# single target
summon armor_stand ~ ~1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_target"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"?\"}"}
# many randomizer
summon armor_stand ~ ~-1 ~ {Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["command_random","box_randomizer"],DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\\"text\\":\\"box\\"}"}
# random-selector
execute at @e[type=minecraft:armor_stand,tag=box_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~1 ~ ~ redstone_block
# action
execute at @e[type=armor_stand,tag=box_target,sort=nearest,limit=1] if block ~ ~ ~ trapped_chest run data modify block ~ ~ ~ LootTable set value "minecraft:chests/spawn_bonus_chest"
# clean-up
execute at @e[type=minecraft:armor_stand,tag=box_randomizer,limit=40] if block ~ ~ ~ command_block if block ~1 ~ ~ redstone_block run setblock ~1 ~ ~ air

# transaction
# price same as netherite sell price.
scoreboard players set random_box_buy Price 50000
#@ impulse
#@ manual
execute at @p[distance=..3] if score @p[distance=0] Wallet < random_box_buy Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
#@ manual
execute at @p[distance=..3] unless entity @a[scores={Transaction=201}] if score @p[distance=0] Wallet >= random_box_buy Price run scoreboard players set @p[distance=0,scores={Transaction=0}] Transaction 201
#@ conditional
scoreboard players operation @p[scores={Transaction=201}] Wallet -= random_box_buy Price
#@ conditional
execute if @p[scores={Transaction=201}] at @e[type=minecraft:armor_stand,tag=box_randomizer,sort=random,limit=1] if block ~ ~ ~ command_block run setblock ~1 ~ ~ redstone_block
#@ conditional
execute if @p[scores={Transaction=201}] at @e[type=minecraft:armor_stand,tag=box_randomizer,limit=40] if block ~ ~ ~ command_block if block ~1 ~ ~ redstone_block run setblock ~1 ~ ~ air
#@ conditional
tellraw @p[scores={Transaction=201}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=201}] Transaction 0

