#@ remove+
#@ positive-x
#@ default manual
#@ default impulse

#tellraw @p [{"text":"There are 16 colors: ","color":"white"},{"text":"[Black], ","color":"black","hoverEvent":{"action":"show_text","value":"Black: black"}},{"text":"[Navy], ","color":"dark_blue","hoverEvent":{"action":"show_text","value":"Navy: dark_blue"}},{"text":"[Grass], ","color":"dark_green","hoverEvent":{"action":"show_text","value":"Grass: dark_green"}},{"text":"[Teal], ","color":"dark_aqua","hoverEvent":{"action":"show_text","value":"Teal: dark_aqua"}},{"text":"[Apple], ","color":"dark_red","hoverEvent":{"action":"show_text","value":"Apple: dark_red"}},{"text":"[Purple], ","color":"dark_purple","hoverEvent":{"action":"show_text","value":"Purple: dark_purple"}},{"text":"[Orange], ","color":"gold","hoverEvent":{"action":"show_text","value":"Orange: gold"}},{"text":"[Silver], ","color":"gray","hoverEvent":{"action":"show_text","value":"Silver: gray"}},{"text":"[Gray], ","color":"dark_gray","hoverEvent":{"action":"show_text","value":"Gray: dark_gray"}},{"text":"[Blue], ","color":"blue","hoverEvent":{"action":"show_text","value":"Blue: blue"}},{"text":"[Green], ","color":"green","hoverEvent":{"action":"show_text","value":"Green: green"}},{"text":"[Cyan], ","color":"aqua","hoverEvent":{"action":"show_text","value":"Cyan: aqua"}},{"text":"[Red], ","color":"red","hoverEvent":{"action":"show_text","value":"Red: red"}},{"text":"[Magenta], ","color":"light_purple","hoverEvent":{"action":"show_text","value":"Magenta: light_purple"}},{"text":"[Yellow], ","color":"yellow","hoverEvent":{"action":"show_text","value":"Yellow: yellow"}},{"text":"[White], ","color":"white","hoverEvent":{"action":"show_text","value":"White: white"}}]

team join Black @p[distance=..3]
team join Navy @p[distance=..3]
team join Grass @p[distance=..3]
team join Teal @p[distance=..3]
team join Apple @p[distance=..3]
team join Purple @p[distance=..3]
team join Orange @p[distance=..3]
team join Silver @p[distance=..3]
team join Gray @p[distance=..3]
team join Blue @p[distance=..3]
team join Green @p[distance=..3]
team join Cyan @p[distance=..3]
team join Red @p[distance=..3]
team join Magenta @p[distance=..3]
team join Yellow @p[distance=..3]
team join White @p[distance=..3]

#@ remove+
#@ positive-x
#@ default impulse

#summon falling_block ~ ~2 ~ {Time:1,BlockState:{Name:"birch_sign"},TileEntityData:{Text2:"{\"text\":\"Black\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"black\"}"}}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Black\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"black\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Navy\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_blue\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Grass\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_green\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Teal\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_aqua\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Apple\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_red\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Purple\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_purple\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Orange\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"gold\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Silver\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"gray\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Gray\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"dark_gray\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Blue\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"blue\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Green\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"green\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Cyan\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"aqua\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Red\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"red\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Magenta\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"light_purple\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"Yellow\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"yellow\"}"}
setblock ~ ~ ~ birch_sign{Text2:"{\"text\":\"White\"}",Text3:"{\"text\":\"||||||||||||||||||||||||||||||||||||\",\"color\":\"white\"}"}
