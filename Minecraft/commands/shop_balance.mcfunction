# withdraw

#@ impulse
#@ manual
tellraw @p[distance=0..3,scores={Wallet=..99}] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute unless entity @a[scores={Transaction=101}] run scoreboard players set @p[distance=0..3,scores={Transaction=0,Wallet=100..}] Transaction 101
#@ conditional
scoreboard players remove @p[scores={Transaction=101}] Wallet 100
#@ conditional
give @p[scores={Transaction=101}] paper{HideFlags:1,display:{Name:"{\"text\":\"Money Order\"}",Lore:["{\"text\":\"$100 bill\"}","{\"text\":\"Value must never change\"}","{\"text\":\"Can be renamed\"}","{\"text\":\"Void if disenchanted\"}"]},Enchantments:[{id:binding_curse,lvl:6}]}
#@ conditional
tellraw @p[scores={Transaction=101}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=101}] Transaction 0

# deposit

#@ impulse
#@ manual
execute unless entity @p[distance=..3,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:6}]}}]}] run tellraw @p[distance=0..3] [{"text":"You do not have this item","color":"red"}]
execute unless entity @a[scores={Transaction=102}] run scoreboard players set @p[distance=0..3,scores={Transaction=0},nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:6}]}}]}] Transaction 102
#@ conditional
clear @p[scores={Transaction=102}] paper{Enchantments:[{id:binding_curse,lvl:6}]} 1
#@ conditional
scoreboard players add @p[scores={Transaction=102}] Wallet 100
#@ conditional
tellraw @p[scores={Transaction=102}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
scoreboard players set @p[scores={Transaction=102}] Transaction 0
