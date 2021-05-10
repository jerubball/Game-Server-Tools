#@ keep

scoreboard objectives add maxhealth dummy

#@ repeat
execute at @a unless score @p[distance=0] maxhealth = @p[distance=0] maxhealth run scoreboard players set @p[distance=0] maxhealth 1
execute unless entity @a[scores={maxhealth=..0}] at @r[scores={maxhealth=1..19},nbt={Inventory:[{Slot:-106b,id:"minecraft:golden_apple"}]}] run scoreboard players remove @p[distance=0] maxhealth 1000
#@ conditional
clear @p[scores={maxhealth=..-1}] minecraft:golden_apple 1
#@ conditional
scoreboard players add @p[scores={maxhealth=..-1}] maxhealth 1001

execute at @a if score @p[distance=0] maxhealth matches 1 run attribute @p[distance=0] minecraft:generic.max_health base set 2
execute at @a if score @p[distance=0] maxhealth matches 2 run attribute @p[distance=0] minecraft:generic.max_health base set 4
execute at @a if score @p[distance=0] maxhealth matches 3 run attribute @p[distance=0] minecraft:generic.max_health base set 6
execute at @a if score @p[distance=0] maxhealth matches 4 run attribute @p[distance=0] minecraft:generic.max_health base set 8
execute at @a if score @p[distance=0] maxhealth matches 5 run attribute @p[distance=0] minecraft:generic.max_health base set 10
execute at @a if score @p[distance=0] maxhealth matches 6 run attribute @p[distance=0] minecraft:generic.max_health base set 12
execute at @a if score @p[distance=0] maxhealth matches 7 run attribute @p[distance=0] minecraft:generic.max_health base set 14
execute at @a if score @p[distance=0] maxhealth matches 8 run attribute @p[distance=0] minecraft:generic.max_health base set 16
execute at @a if score @p[distance=0] maxhealth matches 9 run attribute @p[distance=0] minecraft:generic.max_health base set 18
execute at @a if score @p[distance=0] maxhealth matches 10 run attribute @p[distance=0] minecraft:generic.max_health base set 20
execute at @a if score @p[distance=0] maxhealth matches 11 run attribute @p[distance=0] minecraft:generic.max_health base set 22
execute at @a if score @p[distance=0] maxhealth matches 12 run attribute @p[distance=0] minecraft:generic.max_health base set 24
execute at @a if score @p[distance=0] maxhealth matches 13 run attribute @p[distance=0] minecraft:generic.max_health base set 26
execute at @a if score @p[distance=0] maxhealth matches 14 run attribute @p[distance=0] minecraft:generic.max_health base set 28
execute at @a if score @p[distance=0] maxhealth matches 15 run attribute @p[distance=0] minecraft:generic.max_health base set 30
execute at @a if score @p[distance=0] maxhealth matches 16 run attribute @p[distance=0] minecraft:generic.max_health base set 32
execute at @a if score @p[distance=0] maxhealth matches 17 run attribute @p[distance=0] minecraft:generic.max_health base set 34
execute at @a if score @p[distance=0] maxhealth matches 18 run attribute @p[distance=0] minecraft:generic.max_health base set 36
execute at @a if score @p[distance=0] maxhealth matches 19 run attribute @p[distance=0] minecraft:generic.max_health base set 38
execute at @a if score @p[distance=0] maxhealth matches 20 run attribute @p[distance=0] minecraft:generic.max_health base set 40
