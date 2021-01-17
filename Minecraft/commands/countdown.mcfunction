#@ keep

scoreboard objectives add countdown dummy
bossbar add countdown "Timer"
scoreboard players set ticks countdown 1
scoreboard players set seconds countdown 1
scoreboard players set minutes countdown 1
scoreboard players set max countdown 1
scoreboard players set tickspersecond countdown 20
scoreboard players set ticksperminute countdown 1200
#scoreboard players set secondsperminute countdown 60
scoreboard players set red countdown 600
scoreboard players set yellow countdown 1200
scoreboard players add ticks countdown 10

#@ repeat
execute if score ticks countdown matches 0.. run scoreboard players remove ticks countdown 1
scoreboard players operation minutes countdown = ticks countdown
scoreboard players operation minutes countdown /= ticksperminute countdown
scoreboard players operation seconds countdown = ticks countdown
scoreboard players operation minutes countdown %= ticksperminute countdown
scoreboard players operation seconds countdown /= tickspersecond countdown
execute if score ticks countdown matches -1 run bossbar set countdown players
execute if score ticks countdown matches 0.. run bossbar set countdown players @a[distance=0..]
execute store result bossbar countdown value run scoreboard players get ticks countdown
execute if score ticks countdown matches -1 run scoreboard players set max countdown 1
execute if score max countdown < ticks countdown run scoreboard players operation max countdown = ticks countdown
execute store result bossbar countdown max run scoreboard players get max countdown
execute if score ticks countdown <= red countdown run bossbar set countdown color red
execute if score ticks countdown <= yellow countdown if score ticks countdown > red countdown run bossbar set countdown color yellow
execute if score ticks countdown > yellow countdown run bossbar set countdown color green

#execute if score ticks countdown matches 0.. run title @a[distance=0..] actionbar [{"text":"Time remaining: "},{"score":{"name":"seconds","objective":"countdown"}},{"text":" seconds"}]
execute if score ticks countdown matches 0.. run bossbar set countdown name [{"text":"Time remaining: "},{"score":{"name":"seconds","objective":"countdown"}},{"text":" seconds"}]
execute if score ticks countdown matches 0 run title @a[distance=0..] title "Time's up!"
execute if score ticks countdown = red countdown run title @a[distance=0..] subtitle "30 seconds remaining"
#execute if score ticks countdown = red countdown run title @a[distance=0..] title ""
#@ conditional
title @a[distance=0..] title ""
