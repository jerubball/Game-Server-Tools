#@ keep

#@ impulse
scoreboard objectives add warp trigger

#@ repeat
scoreboard players enable @a warp

execute unless entity @a[scores={warp=-1}] run scoreboard players set @p[scores={warp=1}] warp -1
tp @p[scores={Warp=-1}] ~ ~ ~
scoreboard players set @p[scores={Warp=-1}] Warp 0
