#@ keep

#@ impulse
scoreboard objectives add warp trigger

#@ repeat
scoreboard players enable @a warp
execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
tellraw @p[scores={warp=-1}] [{"text":"List of warp points: "},{"text":"[1], ","underlined":true,"hoverEvent":{"action":"show_text","value":"List warps"}}]
scoreboard players set @p[scores={warp=-1}] warp 0

#execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
#tp @p[scores={warp=-1}] ~ ~ ~
#scoreboard players set @p[scores={warp=-1}] warp 0

#scoreboard objectives add Group dummy
#execute at @a unless score @p[distance=0] Group = @p[distance=0] Group run scoreboard players set @p[distance=0] Group 0


scoreboard objectives add shop trigger
execute unless entity @a[scores={shop=-1}] run scoreboard players set @p[scores={shop=1}] shop -1
tp @p[scores={shop=-1}] ~ ~ ~
scoreboard players set @p[scores={shop=-1}] warp 0

#@ impulse
#@ manual
scoreboard objectives add jerubball trigger
#@ repeat
#@ manual
scoreboard players enable @a jerubball

execute unless entity @a[scores={jerubball=-1}] run scoreboard players set @p[scores={jerubball=1..}] jerubball -1
tp @p[scores={jerubball=-1}] jerubball
scoreboard players set @p[scores={jerubball=-1}] jerubball 0


scoreboard players enable @a[scores={Group=1..}] jerubball
#execute if entity jerubball run scoreboard players enable @a[scores={Group=1..}] jerubball
tp @a[scores={jerubball=1..}] jerubball
scoreboard players reset @a[scores={jerubball=1..}] jerubball
execute unless entity jerubball run scoreboard players reset @a jerubball
