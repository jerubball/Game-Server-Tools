#@ keep

scoreboard objectives add jailed dummy

#@ repeat
execute if entity @e[distance=..20,type=!player,type=!item] run kill @e[distance=..20,type=!player,type=!item,sort=nearest,limit=1]
execute if entity @a[distance=20..,scores={jailed=1..3}] run tp @a[distance=20..,scores={jailed=1..3},sort=nearest] ~ ~-2 ~
execute if entity @a[scores={jailed=1},gamemode=!adventure] run gamemode adventure @a[scores={jailed=1},gamemode=!adventure]
execute if entity @a[scores={jailed=2},gamemode=!survival] run gamemode survival @a[scores={jailed=2},gamemode=!survival]
execute if entity @a[scores={jailed=3..4},gamemode=!spectator] run gamemode spectator @a[scores={jailed=3..4},gamemode=!spectator]
