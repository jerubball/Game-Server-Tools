scoreboard objectives add Job1_1 minecraft.mined:minecraft.stone
#execute as @a if score @s Job1_1 matches 2.. run xp add @s 1
execute as @a if score @s Job1_1 matches 2.. at @s run summon experience_orb ~ ~ ~ {Value:1s}
execute as @a if score @s Job1_1 matches 2.. run scoreboard players set @s Job1_1 0
