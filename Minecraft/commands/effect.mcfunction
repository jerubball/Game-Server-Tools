#10 speed 1
#15 luck 1
#20 haste 1
#25 night vision
#30 speed 2
#35 luck 2
#40 haste 2
#45 water breathing
#50 strength 1
#55 speed 3
#60 resistence 1
#65 luck 3
#70 strength 2
#75 haste 3
#80 resistance 2
#85 fire resistance
#90 strength 3
#95 saturation
#100 resistence 3

scoreboard objectives add effect trigger
scoreboard players enable @a effect

execute as @a[gamemode=!spectator,scores={effect=1..},level=10..29] run effect give @s speed 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=15..34] run effect give @s luck 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=20..39] run effect give @s haste 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=25..] run effect give @s night_vision 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=30..54] run effect give @s speed 2 1 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=35..64] run effect give @s luck 2 1 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=40..74] run effect give @s haste 2 1 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=45..] run effect give @s water_breathing 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=50..69] run effect give @s strength 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=55..] run effect give @s speed 2 2 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=60..79] run effect give @s resistance 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=65..] run effect give @s luck 2 2 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=70..89] run effect give @s strength 2 1 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=75..] run effect give @s haste 2 2 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=80..99] run effect give @s resistance 2 1 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=85..] run effect give @s fire_resistance 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=90..] run effect give @s strength 2 2 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=95..] run effect give @s saturation 2 0 true
execute as @a[gamemode=!spectator,scores={effect=1..},level=100..] run effect give @s resistance 2 2 true
