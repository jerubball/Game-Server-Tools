
give @p minecraft:player_head{SkullOwner:"jerubball"}
give @p minecraft:leather_chestplate{display:{color:6571327}}
give @p minecraft:leather_leggings{display:{color:8679517}}
give @p minecraft:leather_boots{display:{color:1710618}}

execute at @e[type=armor_stand,distance=0..20] run data merge entity @e[limit=1,distance=0] {Invulnerable:1b,NoGravity:1b,ShowArms:1b,CustomNameVisible:1b,Pose:{Head:[0.0f, 0.0f, 0.0f],Body:[0.0f, 0.0f, 0.0f]}}

data merge entity @e[type=armor_stand,distance=0..20,limit=1,sort=nearest] {HandItems:[{id:"minecraft:air",Count:1b},{}]}
