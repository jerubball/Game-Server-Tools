#@ keep

scoreboard objectives add Timer dummy
scoreboard players set itemtimer Timer 0

#@ repeat
scoreboard players add itemtimer Timer 1
# 15 mins 18000 ticks
execute if score itemtimer Timer matches 18000.. run scoreboard players set itemtimer Timer 0
execute if score itemtimer Timer matches 0 run kill @e[type=item,limit=100,nbt={"OnGround":1b}]
execute if score itemtimer Timer matches 17400 run tellraw @a [{"text":"[Server] ","color":"gray"},{"text":"warning: ","color":"red","bold":true},{"text":"all ground item will be cleared in 30 seconds.","color":"white"}]



#@ keep

scoreboard objectives add ItemDecay dummy

#@ repeat
scoreboard players add @e[type=item,nbt={"OnGround":1b}] ItemDecay 1
# 5 mins 6000 ticks; 2.5 mins 3000 ticks
execute as @e[type=item,scores={ItemDecay=3000..}] run kill @s
