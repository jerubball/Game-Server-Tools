
scoreboard objectives add Health health
scoreboard objectives add Food food
scoreboard objectives add Air air
scoreboard objectives add Armor armor
scoreboard objectives add XP xp
scoreboard objectives add Level level
scoreboard objectives add Deaths deathCount
scoreboard objectives add TotalKills totalKillCount
scoreboard objectives add PlayerKills playerKillCount

scoreboard objectives setdisplay belowName Health
scoreboard objectives setdisplay list Level
scoreboard objectives setdisplay sidebar Deaths

scoreboard players set @a Deaths 0
scoreboard players set @a TotalKills 0
scoreboard players set @a PlayerKills 0
