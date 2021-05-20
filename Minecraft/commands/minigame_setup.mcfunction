#@ keep

worldborder center ~ ~
worldborder set 2001
spreadplayers ~ ~ 500 1000 under 200 false @a[gamemode=adventure,distance=0..20]
execute at @a run spawnpoint @p[distance=0]
gamemode survival @a[gamemode=adventure]

give @a[gamemode=survival] bread 32
give @a[gamemode=survival] compass 1
give @a[gamemode=survival] stone_axe 1
give @a[gamemode=survival] iron_pickaxe 1

scoreboard players set ticks countdown 36000
execute if score ticks countdown matches 18000 run worldborder add -1800 1800

#@ impuse
#@ manual
spreadplayers ~ ~ 500 1000 under 200 false @p[distance=0..20]
