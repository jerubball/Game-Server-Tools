[h1][b]In-game description[/b][/h1]
Provides multiplayer console commands for DST.
This enhances some of built-in consle commands that strts with c_
New commands start with x_

[h1][b]Overview[/b][/h1]
This mod introduces new functions which can be used by server admins.
Enhancements are made based on existing "consolecommands.lua" script.

Source code and detailed description can be found at https://github.com/jerubball/Dont-Starve-Together-Server-Tools/tree/master/ExtendedConsoleCommands

[h1][b]List of commands[/b][/h1]

[h1]GetPlayer(player)[/h1]
This command has same behavior as [code]ListingOrConsolePlayer(input)[/code] in "consolecommands.lua", which is only defined locally. This command is accessible anywhere.
In this command and in the following commands, [b]player[/b] can be either of three.
[list]
[*]Actual player object obtained by [code]ThePlayer[/code] or [code]AllPlayers[1][/code]
[*]Numerical ID of player. This can be obtained by [code]c_listplayers()[/code] or [code]c_listallplayers()[/code] or pressing "Tab" key on keyboard.
[*]Player name surrounded with quotation mark. For instance, [code]"jerubball"[/code]
[/list]
If [b]player[/b] is omitted, the command will automatically target the player who submitted the command. This is true for the following commands as well.

For example, [code]x_sethunger(ThePlayer, 1)[/code] will set hunger of player who enters the command to 100 percent.
Also, [code]x_give(AllPlayers[2], "log", 10)[/code] or [code]x_give(2, "log", 10)[/code] will give 10 logs to player with ID 2. (This is usually the second player who entered the game. Press "Tab" to see all player list.)
Another example, [code]x_setinvincible("jerubball")[/code] will toggle invincibility for player named [i]jerubball[/i].

[h1]ApplyAllPlayers(command, ...)[/h1]
Apply given command to all players.
For example, [code]ApplyAllPlayers(x_give, "lucky_goldnugget")[/code] will give 1 Lucky Gold Nugget to all players.

[h1]ApplyThePlayer(command, ...)[/h1]
Apply given command to current player.

[h1]x_freecrafting(player, mode)[/h1]
Enables/Disables creative build mode for player.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle creative build mode.

[h1]x_unlockrecipe(player, prefab)[/h1]
Unlocks item recipe for player.
[b]prefab[/b] is debug name assigned to each item.

[h1]x_setinvincible(player, mode)[/h1]
Sets invincibility of player.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle creative build mode.

[h1]x_setabsorption(player, percent)[/h1]
Sets absorption/armor of player on scale of 0.0 (full damage) to 1.0 (no damage).
[b]percent[/b] is 1 if omitted.

[h1]x_kill(player)[/h1]
Kills player.
[b]Warning[/b]: As stated above, omitting [b]player[/b] will target the initiating player by default.

[h1]x_revive(player)[/h1]
Revives player.
Omitting [b]player[/b] goes same for this as well.

[h1]x_sethealth(player, percent)[/h1]
Sets health of player on scale of 0.0 (min health) to 1.0 (max health).
[b]percent[/b] is 1 if omitted.

[h1]x_setmaxhealth(player, number)[/h1]
Sets maximum possible health of player. This also sets health to that number as well.
Default value varies for each character.
[b]number[/b] is 100 if omitted.

[h1]x_setminhealth(player, number)[/h1]
Sets minimum possible health of player.
If [b]number[/b] is set to nonzero positive number, player is practically invincible.
Default value is 0.
[b]number[/b] is 0 if omitted.

[h1]x_setsanity(player, percent)[/h1]
Sets sanity of player on scale of 0.0 (no sanity) to 1.0 (full sanity).
[b]percent[/b] is 1 if omitted.

[h1]x_setmaxsanity(player, number)[/h1]
Sets maximum possible sanity of player. This also sets sanity to that number as well.
[b]number[/b] is 100 if omitted.

[h1]x_sethunger(player, percent)[/h1]
Sets hunger of player on scale of 0.0 (hungry) to 1.0 (full).
[b]percent[/b] is 1 if omitted.

[h1]x_setmaxhunger(player, number)[/h1]
Sets maximum possible hunger of player. This also sets hunger to that number as well.
[b]number[/b] is 100 if omitted.

[h1]x_pausehunger(player, mode)[/h1]
Pauses/Resumes depletion of hunger for player.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle depletion.

[h1]x_setbeaverness(player, percent)[/h1]
Sets beaverness of Woodie on scale of 0.0 (Werebeaver) or 1.0 (normal).
[b]percent[/b] is 1 if omitted.

[h1]x_setmoisture(player, percent)[/h1]
Sets moisture/wetness of player on scale of 0.0 (dry) to 1.0 (wet).
[b]percent[/b] is 0 if omitted.

[h1]x_setmoisturelevel(player, number)[/h1]
Sets moisture/wetness level of player.
[b]number[/b] is 0 if omitted.

[h1]x_settemperature(player, number)[/h1]
Sets temperature level of player.
Player freezes at 0 and overheats at 70.
[b]number[/b] is 25 if omitted.

[h1]x_pausetemperature(player, mode)[/h1]
Fixes/Unfixes change of temperature for player.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle temperature change.

[h1]x_setbuff(player)[/h1]
Buffs player.
This sets hunger, sanity, and health to 500.
This does [b]not[/b] make player invincible, and does [b]not[/b] remove any negative effect. (i.e. wetness, freezing, overheating)

[h1]x_godmode(player, mode)[/h1]
Carries same action as [code]c_godmode(player)[/code] with override option on invincibility.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle temperature change.

[h1]x_supergodmode(player, mode)[/h1]
Carries same action as [code]c_supergodmode(player)[/code] with override option on invincibility.
[b]mode[/b] can be either [code]true[/code] or [code]false[/code]
If [b]mode[/b] is omitted, this will toggle temperature change.

[h1]x_hypergodmode(player)[/h1]
Resurrects player; sets hunger, sanity, and health to 1500; reset moisture to 0; set temperature to 30; and make player invincible.
[b]Note[/b]: Unlike [code]c_godmode(player)[/code] or [code]c_supermode(player)[/code] which toggles invincibility, this will always make player invincible.
Invincibility can be turned off with [code]c_godmode(player)[/code] or [code]x_setinvincible(player, mode)[/code] command.

[h1]x_speedmult(player, number)[/h1]
Sets speed multiplier of player.
[b]number[/b] is speed multiplier. 1 if omitted.
[b]Note[/b]: Value higher than 5 may cause movement lag.

[h1]x_give(player, prefab, count, dontselect)[/h1]
Gives item to player. This command behaves similar to [code]c_give(prefab, count, dontselect)[/code] command.
[b]prefab[/b] is debug name assigned to each item.
[b]count[/b] is number of items. 1 if omitted.
[b]dontselect[/b] states whether spawned items should be selected or not. Can be omitted.

[h1]x_goto(destination_player, target_player)[/h1]
Teleports [b]target_player[/b] to [b]destination_player[/b].
This command behaves similar to [code]c_goto(dest)[/code] command.
This command may not work as intended.

[h1]x_move(target_player, destination_player)[/h1]
Teleports [b]target_player[/b] to [b]destination_player[/b].
This command behaves similar to [code]c_move(inst, dest)[/code] command.
This command may not work as intended.

[h1]x_revealmap(player, size, interval)[/h1]
Reveals map for player.
[b]size[/b] is number indicating size to reveal from center of map. 1600 if omitted.
[b]interval[/b] is number indicating gap between each points to reveal. 35 if omitted.
[b]Note[/b]: This may cause lag.

[h1]x_nextcycle(count)[/h1]
Advances to next day.
[b]count[/b] specifies number of day to pass. 1 if omitted.

[h1]x_nextphase(count)[/h1]
Advances to next phase.
[b]count[/b] specifies number of phases to pass. 1 if omitted.
Each phase is one of Day, Dusk, or Night.

[h1]x_setphase(phase)[/h1]
Sets phase of the day.
[b]phase[/b] can be one of following.
[olist]
[*]"day"
[*]"dusk"
[*]"night"
[/olist]
Number from 1 (day) to 3 (night) can be used as well.

[h1]x_setseason(season)[/h1]
Sets current season.
[b]season[/b] can be one of following.
[olist]
[*]"autumn"
[*]"winter"
[*]"spring"
[*]"summer"
[/olist]
Number from 1 (autumn) to 4 (summer) can be used as well.

