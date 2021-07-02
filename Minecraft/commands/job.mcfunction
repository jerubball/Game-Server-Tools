scoreboard objectives add Job1_1 minecraft.mined:minecraft.stone
#execute as @a if score @s Job1_1 matches 2.. run xp add @s 1
execute as @a if score @s Job1_1 matches 2.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job1_1 matches 2.. run scoreboard players set @s Job1_1 0



scoreboard objectives add Job1_1 minecraft.mined:minecraft.stone
scoreboard objectives add Job1_2 minecraft.mined:minecraft.deepslate
scoreboard objectives add Job1_3 minecraft.mined:minecraft.obsidian

execute as @a if score @s Job1_1 matches 3.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job1_1 matches 3.. run scoreboard players set @s Job1_1 0
execute as @a if score @s Job1_2 matches 3.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job1_2 matches 3.. run scoreboard players set @s Job1_2 0
execute as @a if score @s Job1_3 matches 1.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job1_3 matches 1.. run scoreboard players set @s Job1_3 0

scoreboard objectives add Job2_1 minecraft.mined:minecraft.dirt
scoreboard objectives add Job2_2 minecraft.mined:minecraft.grass_block
scoreboard objectives add Job2_3 minecraft.mined:minecraft.gravel
scoreboard objectives add Job2_4 minecraft.mined:minecraft.sand
scoreboard objectives add Job2_5 minecraft.mined:minecraft.red_sand

execute as @a if score @s Job2_1 matches 15.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job2_1 matches 15.. run scoreboard players set @s Job2_1 0
execute as @a if score @s Job2_2 matches 15.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job2_2 matches 15.. run scoreboard players set @s Job2_2 0
execute as @a if score @s Job2_3 matches 15.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job2_3 matches 15.. run scoreboard players set @s Job2_3 0
execute as @a if score @s Job2_4 matches 15.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job2_4 matches 15.. run scoreboard players set @s Job2_4 0
execute as @a if score @s Job2_5 matches 15.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job2_5 matches 15.. run scoreboard players set @s Job2_5 0

scoreboard objectives add Job3_1 minecraft.mined:minecraft.oak_log
scoreboard objectives add Job3_2 minecraft.mined:minecraft.acacia_log
scoreboard objectives add Job3_3 minecraft.mined:minecraft.spruce_log
scoreboard objectives add Job3_4 minecraft.mined:minecraft.birch_log
scoreboard objectives add Job3_5 minecraft.mined:minecraft.jungle_log
scoreboard objectives add Job3_6 minecraft.mined:minecraft.dark_oak_log

execute as @a if score @s Job3_1 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_1 matches 9.. run scoreboard players set @s Job3_1 0
execute as @a if score @s Job3_2 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_2 matches 9.. run scoreboard players set @s Job3_2 0
execute as @a if score @s Job3_3 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_3 matches 9.. run scoreboard players set @s Job3_3 0
execute as @a if score @s Job3_4 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_4 matches 9.. run scoreboard players set @s Job3_4 0
execute as @a if score @s Job3_5 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_5 matches 9.. run scoreboard players set @s Job3_5 0
execute as @a if score @s Job3_6 matches 9.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job3_6 matches 9.. run scoreboard players set @s Job3_6 0

scoreboard objectives add Job4_1 minecraft.mined:minecraft.wheat
scoreboard objectives add Job4_2 minecraft.mined:minecraft.sugar_cane
scoreboard objectives add Job4_3 minecraft.mined:minecraft.beetroots
scoreboard objectives add Job4_4 minecraft.mined:minecraft.carrots
scoreboard objectives add Job4_5 minecraft.mined:minecraft.potatoes
scoreboard objectives add Job4_6 minecraft.mined:minecraft.pumpkin
scoreboard objectives add Job4_7 minecraft.mined:minecraft.melon

execute as @a if score @s Job4_1 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_1 matches 33.. run scoreboard players set @s Job4_1 0
execute as @a if score @s Job4_2 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_2 matches 33.. run scoreboard players set @s Job4_2 0
execute as @a if score @s Job4_3 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_3 matches 33.. run scoreboard players set @s Job4_3 0
execute as @a if score @s Job4_4 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_4 matches 33.. run scoreboard players set @s Job4_4 0
execute as @a if score @s Job4_5 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_5 matches 33.. run scoreboard players set @s Job4_5 0
execute as @a if score @s Job4_6 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_6 matches 33.. run scoreboard players set @s Job4_6 0
execute as @a if score @s Job4_7 matches 33.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job4_7 matches 33.. run scoreboard players set @s Job4_7 0
