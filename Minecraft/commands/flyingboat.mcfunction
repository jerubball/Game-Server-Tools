summon minecraft:boat ~ ~ ~ {Invulnerable:1b,NoGravity:1b,CustomNameVisible:1b,CustomName:"{\"text\":\"the flying boat\"}"}
execute as @e[name="the flying boat",limit=1] at @s if entity @p[distance=0,nbt={SelectedItemSlot:0}] run data modify entity @s Motion[1] set value -0.01d
execute as @e[name="the flying boat",limit=1] at @s if entity @p[distance=0,nbt={SelectedItemSlot:2}] run data modify entity @s Motion[1] set value 0.01d
