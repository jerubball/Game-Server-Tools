
give @p minecraft:player_head{SkullOwner:"jerubball"}
give @p minecraft:leather_chestplate{display:{color:6571327}}
give @p minecraft:leather_leggings{display:{color:8679517}}
give @p minecraft:leather_boots{display:{color:1710618}}

execute as @e[type=armor_stand,distance=0..20] run data merge entity @s {Invulnerable:1b,NoGravity:1b,ShowArms:1b,CustomNameVisible:1b,Rotation:[180.0f,90.0f],Pose:{Head:[0.0f, 0.0f, 0.0f],Body:[0.0f, 0.0f, 0.0f]}}

data merge entity @e[type=armor_stand,distance=0..20,limit=1,sort=nearest] {HandItems:[{id:"minecraft:air",Count:1b},{}]}

summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,ShowArms:1b,CustomNameVisible:1b,CustomName:"{\"text\":\"jerubball\",\"underlined\":true}"}

execute as @e[type=item_frame,distance=0..20] run data merge entity @s {Invulnerable:1b,Fixed:1b}
