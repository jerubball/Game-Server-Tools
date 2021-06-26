#@ keep

#@ repeat
effect give @a[distance=..80,gamemode=!spectator] minecraft:speed 1 1 true
execute at @a unless entity @p[distance=0,nbt={SleepTimer:0s}] run time add 10
execute at @a[nbt={SleepTimer:20s}] run tellraw @a [{"text":""},{"selector":"@p[distance=0]"},{"text":" is using bed","color":"gray"}]

execute if entity @a[distance=..75,gamemode=survival] run gamemode adventure @a[distance=..75,gamemode=survival]
execute if entity @p[distance=76..,gamemode=adventure] run gamemode survival @a[distance=76..,gamemode=adventure]

fill ~ ~ ~ ^ ^1 ^8 air

