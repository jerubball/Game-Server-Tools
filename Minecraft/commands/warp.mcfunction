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
#tellraw @p[scores={warp=-1}] [{"text":"\nList of warp points: "},{"text":"(click number to autofill command)\n ","color":"gray"},{"text":"[1]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 1"}},{"text":" List warps\n "},{"text":"[2]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 2"}},{"text":" Town 1a: Group 9x\n "},{"text":"[3]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 3"}},{"text":" Town 1b: Group 9x\n "},{"text":"[5]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 5"}},{"text":" Village 1: for all\n "},{"text":"[11]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 11"}},{"text":" Town 4: Group 1x\n "},{"text":"[15]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 15"}},{"text":" Town 6: Group 1x\n "},{"text":"[17]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 17"}},{"text":" Town 7: Group 1x\n "},{"text":"[18]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 18"}},{"text":" Town 3: Group 1x\n "},{"text":"[19]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 19"}},{"text":" Town 5: Group 1x\n "},{"text":"[21]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 21"}},{"text":" Village 2: Group 2x\n "},{"text":"[22]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger warp set 22"}},{"text":" Town 2: Group 2x\n "},{"text":"\nAdditional triggers:\n "},{"text":"[spawn]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger spawn"}},{"text":", "},{"text":"[shop]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger shop"}},{"text":", "},{"text":"[randomtp]","color":"yellow","hoverEvent":{"action":"show_text","value":"Click to type this warp"},"clickEvent":{"action":"suggest_command","value":"/trigger randomtp"}},{"text":"\n"}]


execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
#tp @p[scores={warp=-1}] ~ ~ ~
#execute at @a[scores={warp=-1,Group=1..}] unless entity @p[distance=0,scores={Group=2}] run tp @p[distance=0] ~ ~ ~
execute as @a[scores={warp=-1,Group=1..}] unless entity @s[scores={Group=2}] run tp @s ~ ~ ~
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
spreadplayers ~ ~ 1000 10000 under 250 false @p[distance=0..,scores={randomtp=-1}]
scoreboard players set @p[scores={randomtp=-1}] randomtp 0

scoreboard objectives add unstuck trigger
scoreboard players enable @a unstuck
execute unless entity @a[scores={unstuck=-1}] run scoreboard players set @p[scores={unstuck=1..}] unstuck -1
execute as @p[distance=0..,scores={unstuck=-1}] at @s run spreadplayers ~ ~ 1 1 under 250 false @s
scoreboard players set @p[scores={unstuck=-1}] unstuck 0







# teleport with accept and deny

execute if entity @a[scores={jerubball=..-1}] run scoreboard players set @p[scores={jerubball=1}] jerubball 12
execute if entity @a[scores={jerubball=12}] run tellraw @a[scores={jerubball=12}] [{"selector":"jerubball"},{"text":" has pending request from other players","color":"red"}]

execute if entity @a[scores={jerubball=..-57}] run scoreboard players set @p[scores={jerubball=..-57}] jerubball -57
execute unless entity @a[scores={jerubball=..-1}] run scoreboard players set @p[scores={jerubball=1}] jerubball -57
tellraw @a[scores={jerubball=-57}] [{"text":"Teleport request sent to ","color":"gray"},{"selector":"jerubball"}]
execute if entity @a[scores={jerubball=-57}] run tellraw jerubball [{"text":"Teleport requested from ","color":"yellow"},{"selector":"@a[scores={jerubball=-57}]"},{"text":"\n  "},{"text":"[Click to Accept]","color":"green","hoverEvent":{"action":"show_text","value":{"text":"/trigger jerubball set 13","color":"dark_gray"}},"clickEvent":{"action":"run_command","value":"/trigger jerubball set 13"}},{"text":" "},{"text":"[Click to Deny]","color":"red","hoverEvent":{"action":"show_text","value":{"text":"/trigger jerubball set 11","color":"dark_gray"}},"clickEvent":{"action":"run_command","value":"/trigger jerubball set 11"}}]

execute if score jerubball jerubball matches 11 run tellraw @a[scores={jerubball=..-1}] [{"selector":"jerubball"},{"text":" denied teleport request","color":"gray"}]
execute if score jerubball jerubball matches 11 run scoreboard players reset @a[scores={jerubball=..-1}] jerubball

execute if score jerubball jerubball matches 13 run tellraw @a[scores={jerubball=..-1}] [{"selector":"jerubball"},{"text":" accepted teleport request","color":"gray"}]
execute if score jerubball jerubball matches 13 run tp @a[scores={jerubball=..-1}] jerubball
execute if score jerubball jerubball matches 13 run scoreboard players reset @a[scores={jerubball=..-1}] jerubball

tellraw @a[scores={jerubball=-1}] [{"text":"Teleport request to ","color":"gray"},{"selector":"jerubball"},{"text":" expired","color":"gray"}]
execute if entity @a[scores={jerubball=-1}] run tellraw jerubball [{"text":"Teleport request from ","color":"gray"},{"selector":"@a[scores={jerubball=-1}]"},{"text":" expired","color":"gray"}]
scoreboard players add @a[scores={jerubball=..-1}] jerubball 1

scoreboard players reset @a[scores={jerubball=1..}] jerubball
scoreboard players enable @a jerubball
