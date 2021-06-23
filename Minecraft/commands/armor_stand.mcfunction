
give @p minecraft:player_head{SkullOwner:"jerubball"}
give @p minecraft:leather_chestplate{display:{color:6571327}}
give @p minecraft:leather_leggings{display:{color:8679517}}
give @p minecraft:leather_boots{display:{color:1710618}}

execute as @e[type=armor_stand,distance=0..20] run data merge entity @s {Invulnerable:1b,NoGravity:1b,ShowArms:1b,CustomNameVisible:1b,Rotation:[180.0f,90.0f],Pose:{Head:[0.0f, 0.0f, 0.0f],Body:[0.0f, 0.0f, 0.0f]}}

data merge entity @e[type=armor_stand,distance=0..20,limit=1,sort=nearest] {HandItems:[{id:"minecraft:air",Count:1b},{}]}

summon armor_stand ~ ~1.5 ~ {Marker:1b,Invisible:1b,Invulnerable:1b,NoGravity:1b,ShowArms:0b,NoBasePlate:1b,DisabledSlots:16191,CustomNameVisible:1b,CustomName:"{\"text\":\"jerubball\",\"underlined\":true}",Tags:["jerubball"]}
# Tags:["marker","trigger"]
# Tags:["spawn","information"]


summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,ShowArms:0b,NoBasePlate:1b,DisabledSlots:16191,ArmorItems:[{},{},{},{id:"minecraft:glass",Count:1b}]}

execute as @e[type=item_frame,distance=0..20] run data merge entity @s {Invulnerable:1b,Fixed:1b}

summon minecraft:armor_stand ~ ~1 ~ {Invulnerable:1b,NoGravity:1b,Small:1b,Tags:["pointer"],DisabledSlots:16191,Pose:{Head:[180.0f, 45.0f, 0.0f]}}
effect give @e[type=minecraft:armor_stand,tag=pointer,sort=nearest,limit=1] glowing 10000 0 true
execute at jerubball positioned ^ ^ ^2 run tp @e[type=minecraft:armor_stand,tag=pointer,sort=nearest,limit=1] ~ ~1.6 ~
execute at @e[type=armor_stand,tag=pointer,sort=nearest,limit=1] run setblock ~ ~ ~ stone
data modify block ~ ~ ~ TrackOutput set value 0b
