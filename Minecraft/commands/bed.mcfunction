#@ keep
scoreboard objectives add bed trigger

#@ repeat
scoreboard players enable @a bed
execute unless entity @a[scores={bed=-1}] if entity @a[scores={bed=1}] run scoreboard players set @p[scores={bed=1}] bed -1
execute if entity @a[scores={bed=-1}] run summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,DisabledSlots:16191,CustomName:'{"text":"bed"}',Tags:["function_bed"]}
execute if entity @p[scores={bed=-1}] as @e[type=armor_stand,tag=function_bed,sort=nearest,limit=1] run function jerubball:bedexec

# function jerubball:bedexec

execute store result entity @s Pos[0] double 1 run data get entity @p[scores={bed=-1}] SpawnX
execute store result entity @s Pos[1] double 1 run data get entity @p[scores={bed=-1}] SpawnY
execute store result entity @s Pos[2] double 1 run data get entity @p[scores={bed=-1}] SpawnZ
tp @p[scores={bed=-1}] @s
kill @s[type=armor_stand]
scoreboard players reset @p[scores={bed=-1}] bed
