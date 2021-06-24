#@ optional

#@ repeat
title @a actionbar [{"text":"balance: ","color":"red"},{"text":"$","color":"yellow"},{"score":{"name":"*","objective":"Wallet"},"color":"yellow"}]

#@ impulse
scoreboard objectives add Wallet_display1 dummy
scoreboard objectives add Wallet_display2 dummy
scoreboard objectives add Wallet_display3 dummy
scoreboard objectives add Wallet_display4 dummy
scoreboard players set comma_separator Wallet_display1 1000
#scoreboard players set thousand_separator Wallet_display1 1000
#scoreboard players set million_separator Wallet_display1 1000000
#scoreboard players set billion_separator Wallet_display1 1000000000

#@ repeat
#scoreboard players set Timer2 Timer 0
scoreboard players add Timer2 Timer 1
execute if score Timer2 Timer matches 40.. run scoreboard players set Timer2 Timer 0

#@ repeat

execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display4 = @p[distance=0] Wallet
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display3 = @p[distance=0] Wallet_display4
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display4 %= comma_separator Wallet_display1
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display3 /= comma_separator Wallet_display1
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display2 = @p[distance=0] Wallet_display3
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display3 %= comma_separator Wallet_display1
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display2 /= comma_separator Wallet_display1
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display1 = @p[distance=0] Wallet_display2
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display2 %= comma_separator Wallet_display1
execute if score Timer2 Timer matches 0 at @a run scoreboard players operation @p[distance=0] Wallet_display1 /= comma_separator Wallet_display1

# alternative1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display4 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display4 %= comma_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 /= thousand_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 %= comma_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 /= million_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 %= comma_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display1 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display1 /= billion_separator Wallet_display1

# alternative2
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display4 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display4 %= thousand_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 %= million_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display3 /= thousand_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 %= billion_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display2 /= million_separator Wallet_display1
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display1 = @p[distance=0] Wallet
#execute at @a run scoreboard players operation @p[distance=0] Wallet_display1 /= billion_separator Wallet_display1

# display

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=100..999,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=100..999,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=100..999,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=10..99,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=10..99,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=10..99,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=0..9,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=0..9,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=100..999,Wallet_display3=0..9,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=100..999,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=100..999,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=100..999,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=10..99,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=10..99,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=10..99,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=0..9,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=0..9,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=10..99,Wallet_display3=0..9,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=100..999,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=100..999,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=100..999,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=10..99,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=10..99,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=10..99,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=0..9,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=0..9,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=1..,Wallet_display2=0..9,Wallet_display3=0..9,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display1"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=100..999,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=100..999,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=100..999,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=10..99,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=10..99,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=10..99,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=0..9,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=0..9,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=1..,Wallet_display3=0..9,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display2"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=0,Wallet_display3=1..,Wallet_display4=100..999}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":","},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=0,Wallet_display3=1..,Wallet_display4=10..99}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",0"},{"score":{"name":"*","objective":"Wallet_display4"}}]
execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=0,Wallet_display3=1..,Wallet_display4=0..9}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display3"}},{"text":",00"},{"score":{"name":"*","objective":"Wallet_display4"}}]

execute if score Timer2 Timer matches 5 run title @a[scores={Wallet_display1=0,Wallet_display2=0,Wallet_display3=0,Wallet_display4=0..}] actionbar [{"text":"","color":"yellow"},{"text":"balance:","color":"red"},{"text":" $"},{"score":{"name":"*","objective":"Wallet_display4"}}]




# withdraw

#@ impulse
#@ manual
execute if block ~1 ~1 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] run tellraw @p[distance=0,scores={Wallet=..99}] [{"text":"Not enough money. Your balance is $","color":"red"},{"score":{"name":"*","objective":"Wallet"}}]
execute if block ~1 ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=103}] run scoreboard players set @p[distance=0,scores={Wallet=100..}] Transaction 103
#@ conditional
execute if block ~1 ~3 ~ #buttons[powered=true] run scoreboard players remove @p[scores={Transaction=103}] Wallet 100
#@ conditional
execute if block ~1 ~4 ~ #buttons[powered=true] run give @p[scores={Transaction=103}] paper{HideFlags:1,display:{Name:"{\"text\":\"Money Order\"}",Lore:["{\"text\":\"$100 bill\"}","{\"text\":\"Value must never change\"}","{\"text\":\"Can be renamed\"}","{\"text\":\"Void if disenchanted\"}"]},Enchantments:[{id:binding_curse,lvl:6}]}
#@ conditional
execute if block ~1 ~5 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=103}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
execute if block ~1 ~6 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=103}] Transaction 0
execute if block ~1 ~7 ~ #buttons[powered=true] run setblock ~1 ~7 ~ stone_button[powered=false,face=wall,facing=east]

# deposit

#@ impulse
#@ manual
execute if block ~1 ~1 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:6}]}}]}] run tellraw @p[distance=0] [{"text":"You do not have this item","color":"red"}]
execute if block ~1 ~2 ~ #buttons[powered=true] at @p[distance=..3,scores={Transaction=0}] unless entity @a[scores={Transaction=104}] run scoreboard players set @p[distance=0,nbt={Inventory:[{id:"minecraft:paper",tag:{Enchantments:[{id:binding_curse,lvl:6}]}}]}] Transaction 104
#@ conditional
execute if block ~1 ~3 ~ #buttons[powered=true] run clear @p[scores={Transaction=104}] paper{Enchantments:[{id:binding_curse,lvl:6}]} 1
#@ conditional
execute if block ~1 ~4 ~ #buttons[powered=true] run scoreboard players add @p[scores={Transaction=104}] Wallet 100
#@ conditional
execute if block ~1 ~5 ~ #buttons[powered=true] run tellraw @p[scores={Transaction=104}] [{"text":"Your new balance is $","color":"yellow"},{"score":{"name":"*","objective":"Wallet"}}]
#@ conditional
execute if block ~1 ~6 ~ #buttons[powered=true] run scoreboard players set @p[scores={Transaction=104}] Transaction 0
execute if block ~1 ~7 ~ #buttons[powered=true] run setblock ~1 ~7 ~ stone_button[powered=false,face=wall,facing=east]
