
give @p minecraft:player_head{SkullOwner:"jerubball"}
give @p minecraft:leather_chestplate{display:{color:6571327}}
give @p minecraft:leather_leggings{display:{color:8679517}}
give @p minecraft:leather_boots{display:{color:1710618}}

execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] Invulnerable set value 1b
execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] NoGravity set value 1b
execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] ShowArms set value 1b
execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] CustomNameVisible set value 1b
execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] Pose.Head set value [0.0f, 0.0f, 0.0f]
execute at @e[type=armor_stand,distance=0..20] run data modify entity @e[limit=1,distance=0] Pose.Body set value [0.0f, 0.0f, 0.0f]

data merge entity @e[type=armor_stand,distance=0..20,limit=1,sort=nearest] {HandItems:[{id:"minecraft:air",Count:1b},{}]}
