#@ keep

#@ impulse
scoreboard objectives add warp trigger
#scoreboard objectives add Group dummy

#@ repeat
scoreboard players enable @a warp

#execute at @a unless score @p[distance=0] Group = @p[distance=0] Group run scoreboard players set @p[distance=0] Group 0

execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
tellraw @p[scores={warp=-1}] [{"text":"List of warp points:\n "},{"text":"[1]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 1"}},{"text":" List warps\n "}]
scoreboard players set @p[scores={warp=-1}] warp 0

execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
#tp @p[scores={warp=-1}] ~ ~ ~
execute at @a[scores={warp=-1,Group=1..}] unless entity @p[distance=0,scores={Group=2}] run tp @p[distance=0] ~ ~ ~
scoreboard players set @a[scores={warp=-1}] warp 0



scoreboard objectives add shop trigger
scoreboard players enable @a shop
execute unless entity @a[scores={shop=-1}] run scoreboard players set @p[scores={shop=1..}] shop -1
tp @p[scores={shop=-1}] ~ ~ ~
scoreboard players set @p[scores={shop=-1}] shop 0

#@ impulse
#@ manual
scoreboard objectives add jerubball trigger
#@ repeat
#@ manual
scoreboard players enable @a jerubball

execute unless entity @a[scores={jerubball=-1}] run scoreboard players set @p[scores={jerubball=1..}] jerubball -1
tp @p[scores={jerubball=-1}] jerubball
scoreboard players set @p[scores={jerubball=-1}] jerubball 0


#scoreboard players enable @a[scores={Group=1..}] jerubball
#execute if entity jerubball run scoreboard players enable @a[scores={Group=1..}] jerubball
execute if entity jerubball at @a[scores={Group=1..}] unless entity @p[distance=0,scores={Group=2}] run scoreboard players enable @p[distance=0] jerubball
tp @a[scores={jerubball=1..}] jerubball
scoreboard players reset @a[scores={jerubball=1..}] jerubball
execute unless entity jerubball run scoreboard players reset @a jerubball




scoreboard objectives add randomtp trigger
scoreboard players enable @a randomtp
execute unless entity @a[scores={randomtp=-1}] run scoreboard players set @p[scores={randomtp=1..}] randomtp -1
spreadplayers ~ ~ 1000 10000 under 250 false @p[scores={randomtp=-1}]
scoreboard players set @p[scores={randomtp=-1}] randomtp 0

scoreboard objectives add unstuck trigger
scoreboard players enable @a unstuck
execute unless entity @a[scores={unstuck=-1}] run scoreboard players set @p[scores={unstuck=1..}] unstuck -1
execute as @p[scores={unstuck=-1}] at @s run spreadplayers ~ ~ 1 1 under 250 false @s
scoreboard players set @p[scores={unstuck=-1}] unstuck 0
