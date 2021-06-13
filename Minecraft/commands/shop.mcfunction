#@ optional

scoreboard objectives add Wallet dummy
scoreboard objectives add Transaction dummy
scoreboard objectives add Price dummy

# automatic initialize

#@ repeat
#@ manual
execute at @a unless score @p[distance=0] Wallet = @p[distance=0] Wallet run scoreboard players set @p[distance=0] Wallet 0
execute at @a unless score @p[distance=0] Transaction = @p[distance=0] Transaction run scoreboard players set @p[distance=0] Transaction 0
title @a actionbar [{"text":"balance: ","color":"yellow"},{"text":"$","color":"red"},{"score":{"name":"*","objective":"Wallet"},"color":"red"}]

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

# buy item

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
