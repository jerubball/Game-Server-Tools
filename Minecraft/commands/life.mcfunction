#@ keep

scoreboard objectives add life dummy
scoreboard objectives add deathtrigger deathCount
scoreboard objectives add maxhealth dummy

# life

#@ repeat
execute at @a unless score @p[distance=0] life = @p[distance=0] life run scoreboard players set @p[distance=0] life 10
execute unless entity @a[scores={deathtrigger=..-1}] at @r[scores={deathtrigger=1..}] run scoreboard players remove @p[distance=0] deathtrigger 1000
#@ conditional
scoreboard players remove @p[scores={deathtrigger=..-1}] deathtrigger 1
#@ conditional
scoreboard players remove @p[scores={deathtrigger=..-1,life=1..}] life 1
execute at @p[scores={deathtrigger=..-1,maxhealth=3..}] run scoreboard players remove @p[distance=0] maxhealth 1
execute at @p[scores={deathtrigger=..-1}] run scoreboard players add @p[distance=0] deathtrigger 1000
#@ repeat
execute at @p[scores={life=0},gamemode=!creative,gamemode=!spectator] run gamemode spectator @p[distance=0]
execute unless entity @a[scores={deathtrigger=..-1}] at @r[scores={life=1..9},nbt={Inventory:[{Slot:-106b,id:"minecraft:enchanted_golden_apple"}]}] run scoreboard players remove @p[distance=0] deathtrigger 1000
#@ conditional
clear @p[scores={deathtrigger=..-1}] minecraft:enchanted_golden_apple 1
#@ conditional
scoreboard players add @p[scores={deathtrigger=..-1}] life 1
execute at @p[scores={deathtrigger=..-1}] run scoreboard players add @p[distance=0] deathtrigger 1000

# maxhealth

#@ repeat
execute at @a unless score @p[distance=0] maxhealth = @p[distance=0] maxhealth run scoreboard players set @p[distance=0] maxhealth 2
execute unless entity @a[scores={maxhealth=..-1}] at @r[scores={maxhealth=1..39},nbt={Inventory:[{Slot:-106b,id:"minecraft:golden_apple"}]}] run scoreboard players remove @p[distance=0] maxhealth 1000
#@ conditional
clear @p[scores={maxhealth=..-1}] minecraft:golden_apple 1
#@ conditional
scoreboard players add @p[scores={maxhealth=..-1}] maxhealth 2
execute at @p[scores={maxhealth=..-1}] run scoreboard players add @p[distance=0] maxhealth 1000

execute at @a if score @p[distance=0] maxhealth matches 1 run attribute @p[distance=0] minecraft:generic.max_health base set 1
execute at @a if score @p[distance=0] maxhealth matches 2 run attribute @p[distance=0] minecraft:generic.max_health base set 2
execute at @a if score @p[distance=0] maxhealth matches 3 run attribute @p[distance=0] minecraft:generic.max_health base set 3
execute at @a if score @p[distance=0] maxhealth matches 4 run attribute @p[distance=0] minecraft:generic.max_health base set 4
execute at @a if score @p[distance=0] maxhealth matches 5 run attribute @p[distance=0] minecraft:generic.max_health base set 5
execute at @a if score @p[distance=0] maxhealth matches 6 run attribute @p[distance=0] minecraft:generic.max_health base set 6
execute at @a if score @p[distance=0] maxhealth matches 7 run attribute @p[distance=0] minecraft:generic.max_health base set 7
execute at @a if score @p[distance=0] maxhealth matches 8 run attribute @p[distance=0] minecraft:generic.max_health base set 8
execute at @a if score @p[distance=0] maxhealth matches 9 run attribute @p[distance=0] minecraft:generic.max_health base set 9
execute at @a if score @p[distance=0] maxhealth matches 10 run attribute @p[distance=0] minecraft:generic.max_health base set 10
execute at @a if score @p[distance=0] maxhealth matches 11 run attribute @p[distance=0] minecraft:generic.max_health base set 11
execute at @a if score @p[distance=0] maxhealth matches 12 run attribute @p[distance=0] minecraft:generic.max_health base set 12
execute at @a if score @p[distance=0] maxhealth matches 13 run attribute @p[distance=0] minecraft:generic.max_health base set 13
execute at @a if score @p[distance=0] maxhealth matches 14 run attribute @p[distance=0] minecraft:generic.max_health base set 14
execute at @a if score @p[distance=0] maxhealth matches 15 run attribute @p[distance=0] minecraft:generic.max_health base set 15
execute at @a if score @p[distance=0] maxhealth matches 16 run attribute @p[distance=0] minecraft:generic.max_health base set 16
execute at @a if score @p[distance=0] maxhealth matches 17 run attribute @p[distance=0] minecraft:generic.max_health base set 17
execute at @a if score @p[distance=0] maxhealth matches 18 run attribute @p[distance=0] minecraft:generic.max_health base set 18
execute at @a if score @p[distance=0] maxhealth matches 19 run attribute @p[distance=0] minecraft:generic.max_health base set 19
execute at @a if score @p[distance=0] maxhealth matches 20 run attribute @p[distance=0] minecraft:generic.max_health base set 20
execute at @a if score @p[distance=0] maxhealth matches 21 run attribute @p[distance=0] minecraft:generic.max_health base set 21
execute at @a if score @p[distance=0] maxhealth matches 22 run attribute @p[distance=0] minecraft:generic.max_health base set 22
execute at @a if score @p[distance=0] maxhealth matches 23 run attribute @p[distance=0] minecraft:generic.max_health base set 23
execute at @a if score @p[distance=0] maxhealth matches 24 run attribute @p[distance=0] minecraft:generic.max_health base set 24
execute at @a if score @p[distance=0] maxhealth matches 25 run attribute @p[distance=0] minecraft:generic.max_health base set 25
execute at @a if score @p[distance=0] maxhealth matches 26 run attribute @p[distance=0] minecraft:generic.max_health base set 26
execute at @a if score @p[distance=0] maxhealth matches 27 run attribute @p[distance=0] minecraft:generic.max_health base set 27
execute at @a if score @p[distance=0] maxhealth matches 28 run attribute @p[distance=0] minecraft:generic.max_health base set 28
execute at @a if score @p[distance=0] maxhealth matches 29 run attribute @p[distance=0] minecraft:generic.max_health base set 29
execute at @a if score @p[distance=0] maxhealth matches 30 run attribute @p[distance=0] minecraft:generic.max_health base set 30
execute at @a if score @p[distance=0] maxhealth matches 31 run attribute @p[distance=0] minecraft:generic.max_health base set 31
execute at @a if score @p[distance=0] maxhealth matches 32 run attribute @p[distance=0] minecraft:generic.max_health base set 32
execute at @a if score @p[distance=0] maxhealth matches 33 run attribute @p[distance=0] minecraft:generic.max_health base set 33
execute at @a if score @p[distance=0] maxhealth matches 34 run attribute @p[distance=0] minecraft:generic.max_health base set 34
execute at @a if score @p[distance=0] maxhealth matches 35 run attribute @p[distance=0] minecraft:generic.max_health base set 35
execute at @a if score @p[distance=0] maxhealth matches 36 run attribute @p[distance=0] minecraft:generic.max_health base set 36
execute at @a if score @p[distance=0] maxhealth matches 37 run attribute @p[distance=0] minecraft:generic.max_health base set 37
execute at @a if score @p[distance=0] maxhealth matches 38 run attribute @p[distance=0] minecraft:generic.max_health base set 38
execute at @a if score @p[distance=0] maxhealth matches 39 run attribute @p[distance=0] minecraft:generic.max_health base set 39
execute at @a if score @p[distance=0] maxhealth matches 40 run attribute @p[distance=0] minecraft:generic.max_health base set 40
