#@ keep

#@ repeat
effect give @a[distance=..80,gamemode=!spectator] minecraft:speed 1 1 true
execute at @a unless entity @p[distance=0,nbt={SleepTimer:0s}] run time add 10
