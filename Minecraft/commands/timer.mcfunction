#@ keep

scoreboard objectives add Timer dummy
scoreboard players set Timer1 Timer 0

#@ repeat
scoreboard players add Timer1 Timer 1
execute if score Timer1 Timer matches 2000.. run scoreboard players set Timer1 Timer 0

execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 0 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 250 run scoreboard objectives setdisplay sidebar Deaths
execute if score Timer1 Timer matches 250 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 250 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 500 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 500 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 500 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 750 run scoreboard objectives setdisplay sidebar TotalKills
execute if score Timer1 Timer matches 750 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 750 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 1000 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 1000 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 1000 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 1250 run scoreboard objectives setdisplay sidebar Deaths
execute if score Timer1 Timer matches 1250 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 1250 run scoreboard objectives setdisplay list Health

execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay sidebar
execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay belowName Health
execute if score Timer1 Timer matches 1500 run scoreboard objectives setdisplay list Level

execute if score Timer1 Timer matches 1750 run scoreboard objectives setdisplay sidebar PlayerKills
execute if score Timer1 Timer matches 1750 run scoreboard objectives setdisplay belowName Level
execute if score Timer1 Timer matches 1750 run scoreboard objectives setdisplay list Health
