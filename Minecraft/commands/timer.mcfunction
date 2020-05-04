#@ keep

scoreboard objectives add Timer dummy
scoreboard players set Timer1 Timer 0

#@ repeat
scoreboard players add Timer1 Timer 1
execute if score Timer1 Timer matches 2400.. run scoreboard players set Timer1 Timer 0

execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 300 run scoreboard objectives setdisplay sidebar Deaths
execute if score Timer1 Timer matches 300 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 300 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 600 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 600 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 600 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 900 run scoreboard objectives setdisplay sidebar TotalKills
execute if score Timer1 Timer matches 900 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 900 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 1200 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 1200 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 1200 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay sidebar Deaths
execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 1800 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 1800 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 1800 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 2100 run scoreboard objectives setdisplay sidebar PlayerKills
execute if score Timer1 Timer matches 2100 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 2100 run scoreboard objectives setdisplay list Health
