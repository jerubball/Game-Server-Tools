#@ keep

scoreboard objectives add clearblocks trigger
scoreboard objectives add vacuumitems trigger

#@ repeat
scoreboard players enable @a[gamemode=creative] clearblocks
execute at @a[scores={clearblocks=1},gamemode=!spectator,distance=20..] run fill ~-1 ~ ~-1 ~1 ~2 ~1 air destroy
execute at @a[scores={clearblocks=2},gamemode=!spectator,distance=20..] run fill ~-2 ~ ~-2 ~2 ~3 ~2 air destroy
execute at @a[scores={clearblocks=3},gamemode=!spectator,distance=20..] run fill ~-3 ~ ~-3 ~3 ~4 ~3 air destroy
execute at @a[scores={clearblocks=4},gamemode=!spectator,distance=20..] run fill ~-4 ~-1 ~-4 ~4 ~5 ~4 air destroy
execute at @a[scores={clearblocks=5},gamemode=!spectator,distance=20..] run fill ~-5 ~-1 ~-5 ~5 ~6 ~5 air destroy

#@ repeat
scoreboard players enable @a[gamemode=creative] vacuumitems
execute at @a[scores={vacuumitems=1},gamemode=!spectator,distance=20..] run tp @e[type=item,distance=0..5,sort=nearest,limit=1] @p
execute at @a[scores={vacuumitems=2},gamemode=!spectator,distance=20..] run tp @e[type=item,distance=0..10,sort=nearest,limit=2] @p
execute at @a[scores={vacuumitems=3},gamemode=!spectator,distance=20..] run tp @e[type=item,distance=0..20,sort=nearest,limit=3] @p
execute at @a[scores={vacuumitems=4},gamemode=!spectator,distance=20..] run tp @e[type=item,distance=0..40,sort=nearest,limit=4] @p
execute at @a[scores={vacuumitems=5},gamemode=!spectator,distance=20..] run tp @e[type=item,distance=0..80,sort=nearest,limit=5] @p
