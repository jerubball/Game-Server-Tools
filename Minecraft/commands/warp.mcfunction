#@ keep

#@ impulse
scoreboard objectives add warp trigger

#@ repeat
scoreboard players enable @a warp

execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
tp @p[scores={warp=-1}] ~ ~ ~
scoreboard players set @p[scores={warp=-1}] Warp 0

#@ impulse
#@ manual
scoreboard objectives add jerubball trigger
#@ repeat
#@ manual
scoreboard players enable @a jerubball

execute unless entity @a[scores={jerubball=-1}] run scoreboard players set @p[scores={jerubball=1..}] jerubball -1
tp @p[scores={jerubball=-1}] jerubball
scoreboard players set @p[scores={jerubball=-1}] jerubball 0
