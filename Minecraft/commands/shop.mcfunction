#@ optional

scoreboard objectives add Wallet dummy
scoreboard objectives add Transaction dummy
scoreboard objectives add Price dummy

# automatic initialize

#@ repeat
#@ manual
execute at @a unless score @p[distance=0] Wallet = @p[distance=0] Wallet run scoreboard players set @p[distance=0] Wallet 0
execute at @a unless score @p[distance=0] Transaction = @p[distance=0] Transaction run scoreboard players set @p[distance=0] Transaction 0
#data modify block ~ ~1 ~ Text4 set value "[{\"text\":\"$\"},{\"score\":{\"name\":\"apple_buy_16\",\"objective\":\"Price\"}}]"

# initialzie player

#@ impulse
#@ manual
execute if entity @p[distance=..4,scores={Transaction=0..}] run tellraw @p[distance=..4,scores={Transaction=0..}]  [{"text":"Player already initialized.","color":"gray"}]
execute unless entity @p[scores={Transaction=-1}] unless entity @p[distance=..4,scores={Transaction=0..}] run scoreboard players set @p[distance=..4] Transaction -1
#@ conditional
scoreboard players add @p[scores={Transaction=-1}] Wallet 0
#@ conditional
tellraw @p[scores={Transaction=-1}] [{"text":"Player initialized.","color":"yellow"}]
#@ conditional
scoreboard players set @p[scores={Transaction=-1}] Transaction 0

# check balance

#@ impulse
#@ manual
execute unless entity @p[distance=..4,scores={Wallet=0..}] run tellraw @p[distance=..4] [{"text":"Player not initialized.","color":"red"}]
execute if entity @p[distance=..4,scores={Wallet=0..}] run tellraw @p[distance=..4] [{"text":"Your balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]




# buy item with price score & fast button
# Transaction 5

#@ repeat
#@ manual
# or auto
execute if block ~ ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] if score @p[distance=0] Wallet < apple_buy_16 Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~3 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=5}] if score @p[distance=0] Wallet >= apple_buy_16 Price run scoreboard players set @p[distance=0] Transaction 5
#@ conditional
execute if block ~ ~4 ~ #buttons[powered=true] run scoreboard players operation @p[scores={Transaction=5}] Wallet -= apple_buy_16 Price
#@ conditional
execute if block ~ ~5 ~ #buttons[powered=true] run give @p[scores={Transaction=5}] apple 16
#@ conditional
execute if block ~ ~6 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=5}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~7 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=5}] Transaction 0
execute if block ~ ~8 ~ #buttons[powered=true] run setblock ~ ~8 ~ stone_button[powered=false,face=floor]

# sell item with price score & fast button
# Transaction 6

#@ repeat
#@ manual
# or auto
execute if block ~ ~2 ~ #buttons[powered=true] execute at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute if block ~ ~3 ~ #buttons[powered=true] execute at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=6}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] Transaction 6
#@ conditional
execute if block ~ ~4 ~ #buttons[powered=true] run clear @p[scores={Transaction=6}] apple 64
#@ conditional
execute if block ~ ~5 ~ #buttons[powered=true] run scoreboard players operation @p[scores={Transaction=6}] Wallet += apple_sell_64 Price
#@ conditional
execute if block ~ ~6 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=6}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~ ~7 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=6}] Transaction 0
execute if block ~ ~8 ~ #buttons[powered=true] run setblock ~ ~8 ~ stone_button[powered=false,face=floor]




# buy item with price score
# Transaction 3

#@ impulse
#@ manual
execute at @p[distance=..3] if score @p[distance=0] Wallet < apple_buy_16 Price run tellraw @p[distance=0] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute at @p[distance=..3] unless entity @a[scores={Transaction=3}] if score @p[distance=0] Wallet >= apple_buy_16 Price run scoreboard players set @p[distance=0,scores={Transaction=0}] Transaction 3
#@ conditional
scoreboard players operation @p[scores={Transaction=3}] Wallet -= apple_buy_16 Price
#@ conditional
give @p[scores={Transaction=3}] apple 16
#@ conditional
tellraw @p[scores={Transaction=3}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=3}] Transaction 0

# sell item with price score
# Transaction 4

#@ impulse
#@ manual
execute at @p[distance=..3] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute at @p[distance=..3] unless entity @a[scores={Transaction=4}] run scoreboard players set @p[distance=0,scores={Transaction=0},nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] Transaction 4
#@ conditional
clear @p[scores={Transaction=4}] apple 64
#@ conditional
scoreboard players operation @p[scores={Transaction=4}] Wallet += apple_sell_64 Price
#@ conditional
tellraw @p[scores={Transaction=4}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
scoreboard players set @p[scores={Transaction=4}] Transaction 0




# buy item
# Transaction 1

#@ impulse
#@ manual
tellraw @p[distance=0..4,scores={Wallet=..63}] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute unless entity @a[scores={Transaction=1}] run scoreboard players set @p[distance=0..4,scores={Transaction=0,Wallet=64..}] Transaction 1
#@ conditional
scoreboard players remove @p[scores={Transaction=1}] Wallet 64
#@ conditional
give @p[scores={Transaction=1}] apple 64
#@ conditional
tellraw @p[scores={Transaction=1}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=1}] Transaction 0

# sell item
# Transaction 2

#@ impulse
#@ manual
execute unless entity @p[distance=..4,nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] run tellraw @p[distance=0..4] [{"text":"You do not have this item","color":"red"}]
execute unless entity @a[scores={Transaction=2}] run scoreboard players set @p[distance=0..4,scores={Transaction=0},nbt={Inventory:[{id:"minecraft:apple",Count:64b}]}] Transaction 2
#@ conditional
clear @p[scores={Transaction=2}] apple 64
#@ conditional
scoreboard players add @p[scores={Transaction=2}] Wallet 64
#@ conditional
tellraw @p[scores={Transaction=2}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=2}] Transaction 0




# armor stand display
#summon armor_stand ~ ~ ~ {Invisible:1,Invulnerable:1,NoGravity:1,Small:1,DisabledSlots:16191,CustomNameVisible:1,CustomName:"{\"text\":\"glass\"}",ArmorItems:[{},{},{},{id:glass,Count:1b}],Tags:["command_shop","test"]}
#execute at @e[type=armor_stand,tag=command_shop] run setblock ~ ~ ~ sea_lantern
execute as @e[type=armor_stand,tag=command_shop] run data modify entity @s CustomNameVisible set value 0b
execute as @e[type=armor_stand,tag=shop_adjust] run data modify entity @s Pose set value {Head:[20.0f, 0.0f, 0.0f]}
execute as @e[type=armor_stand,tag=shop_adjust] at @s run tp @s ~ 64.25 ~
execute as @e[type=armor_stand,sort=nearest,limit=1] run data modify entity @s Pose merge value {Head:[-150.0f,0.0f,-30.0f]}
execute as @e[type=armor_stand,tag=ore] run data modify entity @s Tags append value "shop_adjust"
#xecute at @a[distance=..60] run execute as @e[type=armor_stand,distance=..6,tag=command_shop] at @s run tp @s ~ ~ ~ ~-3 0
execute if entity @p[distance=..80] as @e[type=armor_stand,tag=command_shop] at @s if entity @p[distance=..5] run tp @s ~ ~ ~ ~-3 0
setblock ~ ~ ~ birch_sign{Text1:"{\"text\":\"Buy&Sell\"}",Text2:"{\"text\":\"x16\"}",Text4:"[{\"text\":\"$\"},{\"score\":{\"objective\":\"Price\",\"name\":\"buy_sell\"}}]"}
