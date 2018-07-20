# [Extended Console Commands](https://steamcommunity.com/sharedfiles/filedetails/?id=1411687865) Mod
Mod for Don't Starve Together.
Link to master branch of this page: https://git.io/f4bxO

## In-game description
Provides multiplayer console commands for DST.

This enhances some of built-in consle commands that strts with c_

New commands start with x_

## Overview
This mod introduces new functions which can be used by server admins.

Enhancements are made based on existing "consolecommands.lua" script.

---

# List of Commands

---

## GetPlayer(player)
This command has same behavior as `ListingOrConsolePlayer(input)` in "consolecommands.lua", which is only defined locally. This command is accessible anywhere.

In this command and in the following commands, **player** can be either of three.

* Actual player object obtained by `ThePlayer` or `AllPlayers[1]`.
* Numerical ID of player. This can be obtained by `c_listplayers()` or `c_listallplayers()` or pressing "Tab" key on keyboard.
* Player name surrounded with quotation mark. For instance, `"jerubball"`.

If **player** is omitted, the command will automatically target the player who submitted the command. This is true for the following commands as well.

For example, `x_sethunger(ThePlayer, 1)` will set hunger of player who enters the command to 100 percent.

Also, `x_give(AllPlayers[2], "log", 10)` or `x_give(2, "log", 10)` will give 10 logs to player with ID 2. (This is usually the second player who entered the game. Press "Tab" to see all player list.)

Another example, `x_setinvincible("jerubball")` will toggle invincibility for player named [i]jerubball[/i].

---

## ApplyAllPlayers(command, ...)
Apply given command to all players.

For example, `ApplyAllPlayers(x_give, "lucky_goldnugget")` will give 1 Lucky Gold Nugget to all players.

---

## ApplyThePlayer(command, ...)
Apply given command to current player.

---

## x_freecrafting(player, mode)
Enables/Disables creative build mode for player.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle creative build mode.

---

## x_unlockrecipe(player, prefab)
Unlocks item recipe for player.

**prefab** is debug name assigned to each item.

---

## x_setinvincible(player, mode)
Sets invincibility of player.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle creative build mode.

---

## x_setabsorption(player, percent)
Sets absorption/armor of player on scale of 0.0 (full damage) to 1.0 (no damage).

**percent** is 1 if omitted.

---

## x_kill(player)
Kills player.

**Warning**: As stated above, omitting **player** will target the initiating player by default.

---

## x_revive(player)
Revives player.

Omitting **player** goes same for this as well.

---

## x_sethealth(player, percent)
Sets health of player on scale of 0.0 (min health) to 1.0 (max health).

**percent** is 1 if omitted.

---

## x_setmaxhealth(player, number)
Sets maximum possible health of player. This also sets health to that number as well.

Default value varies for each character.

**number** is 100 if omitted.

---

## x_setminhealth(player, number)
Sets minimum possible health of player.

If **number** is set to nonzero positive number, player is practically invincible.

Default value is 0.

**number** is 0 if omitted.

---

## x_setpenalty(player, percent)
Sets health penalty of player on scale of 0.0 (no penalty) to 1.0 (maximum penalty).

**number** is 0 if omitted.

**Note**: Maximum possible penalty is 0.75.

---

## x_setsanity(player, percent)
Sets sanity of player on scale of 0.0 (no sanity) to 1.0 (full sanity).

**percent** is 1 if omitted.

---

## x_setmaxsanity(player, number)
Sets maximum possible sanity of player. This also sets sanity to that number as well.

**number** is 100 if omitted.

---

## x_sethunger(player, percent)
Sets hunger of player on scale of 0.0 (hungry) to 1.0 (full).

**percent** is 1 if omitted.

---

## x_setmaxhunger(player, number)
Sets maximum possible hunger of player. This also sets hunger to that number as well.

**number** is 100 if omitted.

---

## x_pausehunger(player, mode)
Pauses/Resumes depletion of hunger for player.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle depletion.

---

## x_setbeaverness(player, percent)
Sets beaverness of Woodie on scale of 0.0 (Werebeaver) or 1.0 (normal).

**percent** is 1 if omitted.

---

## x_setmoisture(player, percent)
Sets moisture/wetness of player on scale of 0.0 (dry) to 1.0 (wet).

**percent** is 0 if omitted.

---

## x_setmoisturelevel(player, number)
Sets moisture/wetness level of player.

**number** is 0 if omitted.

---

## x_settemperature(player, number)
Sets temperature level of player.

Player freezes at 0 and overheats at 70.

**number** is 25 if omitted.

---

## x_pausetemperature(player, mode)
Fixes/Unfixes change of temperature for player.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle temperature change.

---

## x_setbuff(player)
Buffs player.

This sets hunger, sanity, and health to 500.

This does **not** make player invincible, and does **not** remove any negative effect. (i.e. wetness, freezing, overheating)

---

## x_godmode(player, mode)
Carries same action as `c_godmode(player)` with override option on invincibility.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle temperature change.

---

## x_supergodmode(player, mode)
Carries same action as `c_supergodmode(player)` with override option on invincibility.

**mode** can be either `true` or `false`.

If **mode** is omitted, this will toggle temperature change.

---

## x_hypergodmode(player)
Resurrects player; sets hunger, sanity, and health to 1500; reset moisture to 0; set temperature to 30; and make player invincible.

**Note**: Unlike `c_godmode(player)` or `c_supermode(player)` which toggles invincibility, this will always make player invincible.

Invincibility can be turned off with `c_godmode(player)` or `x_setinvincible(player, mode)` command.

---

## x_speedmult(player, number)
Sets speed multiplier of player.

**number** is speed multiplier. 1 if omitted.

**Note**: Value higher than 5 may cause movement lag.

---

## x_give(player, prefab, count, dontselect)
Gives item to player. This command behaves similar to `c_give(prefab, count, dontselect)` command.

**prefab** is debug name assigned to each item.

**count** is number of items. 1 if omitted.

**dontselect** states whether spawned items should be selected or not. Can be omitted.

---

## x_removeslot(player, slot)
Removes item in given slot of player.

**slot** is number between 1 and 15, indicating position of inventory slot from left (1) to right (15), excluding added slots from backpack.

---

## x_dropeverything(player, slot)
Drops all items of player. This will drop all items in the same way items are dropped when player dies.

---

## x_goto(destination_player, target_player)
Teleports **target_player** to **destination_player**.

This command behaves similar to `c_goto(dest)` command.

This command may not work as intended.

---

## x_move(target_player, destination_player)
Teleports **target_player** to **destination_player**.

This command behaves similar to `c_move(inst, dest)` command.

This command may not work as intended.

---

## x_revealmap(player, size, interval)
Reveals map for player.

**size** is number indicating size to reveal from center of map. 1600 if omitted.

**interval** is number indicating gap between each points to reveal. 35 if omitted.

**Note**: This may cause lag.

---

## x_nextcycle(count)
Advances to next day.

**count** specifies number of day to pass. 1 if omitted.

---

## x_nextphase(count)
Advances to next phase.

**count** specifies number of phases to pass. 1 if omitted.

Each phase is one of Day, Dusk, or Night.

---

## x_setphase(phase)
Sets phase of the day.

**phase** can be one of following.

1. "day"
2. "dusk"
3. "night"

Number from 1 (day) to 3 (night) can be used as well.

---

## x_setseason(season)
Sets current season.

**season** can be one of following.

1. "autumn"
2. "winter"
3. "spring"
4. "summer"

Number from 1 (autumn) to 4 (summer) can be used as well.

---

## x_setrain(mode)
Starts/Stops rain.

**mode** can be either `true` or `false`.

---
