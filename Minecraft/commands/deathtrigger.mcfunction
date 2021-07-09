scoreboard objectives add DeathTrigger deathCount
scoreboard objectives add DeathPosX dummy
scoreboard objectives add DeathPosY dummy
scoreboard objectives add DeathPosZ dummy

execute if entity @a[scores={DeathTrigger=1..}] as @a[scores={DeathTrigger=1..}] store result score @s DeathPosX run data get entity @s Pos[0]
execute if entity @a[scores={DeathTrigger=1..}] as @a[scores={DeathTrigger=1..}] store result score @s DeathPosY run data get entity @s Pos[1]
execute if entity @a[scores={DeathTrigger=1..}] as @a[scores={DeathTrigger=1..}] store result score @s DeathPosZ run data get entity @s Pos[2]
execute if entity @a[scores={DeathTrigger=1..}] run tellraw @a[scores={DeathTrigger=1..}] [{"text":"You died at: (x ","color":"green"},{"score":{"name":"*","objective":"DeathPosX"},"color":"white"},{"text":", y "},{"score":{"name":"*","objective":"DeathPosY"},"color":"white"},{"text":", z "},{"score":{"name":"*","objective":"DeathPosY"},"color":"white"},{"text":")"}]
execute if entity @a[scores={DeathTrigger=1..}] run scoreboard players set @a[scores={DeathTrigger=1..}] DeathTrigger 0
