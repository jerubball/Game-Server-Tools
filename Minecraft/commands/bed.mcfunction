#@ keep
scoreboard objectives add bed trigger

#@ repeat
execute unless entity @a[scores={bed=..-1}] if entity @a[scores={bed=1}] run scoreboard players set @p[scores={bed=1}] bed -1
execute if entity @a[scores={bed=-1},nbt={SpawnDimension:"minecraft:overworld"}] if data entity @p[scores={bed=-1},nbt={SpawnDimension:"minecraft:overworld"}] SpawnX if data entity @p[scores={bed=-1},nbt={SpawnDimension:"minecraft:overworld"}] SpawnY if data entity @p[scores={bed=-1},nbt={SpawnDimension:"minecraft:overworld"}] SpawnZ run scoreboard players set @p[scores={bed=-1},nbt={SpawnDimension:"minecraft:overworld"}] bed -2
execute if entity @a[scores={bed=-1}] run tellraw @p[scores={bed=-1}] [{"text":"You do not have bed or spawn point in overworld","color":"red"}]
execute if entity @a[scores={bed=-2}] run summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,DisabledSlots:16191,CustomName:'{"text":"bed"}',Tags:["function_bed"]}
execute if entity @p[scores={bed=-2}] as @e[type=armor_stand,tag=function_bed,sort=nearest,limit=1] run function jerubball:bedexec
scoreboard players reset @p[scores={bed=..-1}] bed
scoreboard players enable @a bed

# function jerubball:bedexec

execute store result entity @s Pos[0] double 1 run data get entity @p[scores={bed=-2}] SpawnX
execute store result entity @s Pos[1] double 1 run data get entity @p[scores={bed=-2}] SpawnY
execute store result entity @s Pos[2] double 1 run data get entity @p[scores={bed=-2}] SpawnZ
execute at @s run tp @p[scores={bed=-2}] ~.5 ~ ~.5
kill @s[type=armor_stand]
