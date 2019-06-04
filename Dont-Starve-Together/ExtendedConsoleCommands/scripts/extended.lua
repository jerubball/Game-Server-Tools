
function GetPlayer(input)
    if type(input) == "string" or type(input) == "number" then
        return UserToPlayer(input)
    else
        return input or ConsoleCommandPlayer()
    end
end

function ApplyAllPlayers(func, ...)
    for id, player in ipairs(AllPlayers) do
        func(player, unpack(arg))
    end
end

function ApplyThePlayer(func, ...)
    func(ThePlayer or GetPlayer(), unpack(arg))
end

function ApplyInfo(obj, func, proc, delim)
    if type(func) ~= "function" then
        func = print
    end
    if type(proc) ~= "function" then
        proc = function (x) return x end
    end
    if type(delim) ~= "string" then
        delim = " - "
    end
    for k,v in pairs(proc(obj)) do
        func(tostring(k)..delim..tostring(v))
    end
end

function ApplyPairInfo(obj, func, delim)
    ApplyInfo(obj, func, nil, delim)
end

function ApplyTableInfo(obj, func, delim)
    ApplyInfo(obj, func, getmetatable, delim)
end

function ApplyDebugInfo(obj, func, delim)
    ApplyInfo(obj, func, debug.getinfo, delim)
end

-- Some helper shortcut functions
function x_freecrafting(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.builder ~= nil then
        SuUsed("x_freecrafting", true)
        if type(mode) == "boolean" then
            player.components.builder.freebuildmode = mode
            player:PushEvent("unlockrecipe")
        else
            player.components.builder:GiveAllRecipes()
        end
        player:PushEvent("techlevelchange")
    end
end

function x_unlockrecipe(inst, prefab)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.builder ~= nil then
        SuUsed("x_unlockrecipe", true)
        if type(prefab) == "string" then
            player.components.builder:UnlockRecipe(prefab)
            player:PushEvent("techlevelchange")
        end
    end
end

function x_setinvincible(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setinvincible", true)
        if type(mode) ~= "boolean" then
            mode = not player.components.health:IsInvincible()
        end
        player.components.health:SetInvincible(mode)
    end
end

function x_setabsorption(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setabsorption", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.health:SetAbsorptionAmount(num)
    end
end

function x_kill(inst)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_kill", true)
        player:PushEvent("death")
        print("Killing "..player.name..".")
    end
end

function x_revive(inst)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil then
        SuUsed("x_revive", true)
        if player:HasTag("playerghost") then
            player:PushEvent("respawnfromghost")
            print("Reviving "..player.name.." from ghost.")
        elseif player:HasTag("corpse") then
            player:PushEvent("respawnfromcorpse")
            print("Reviving "..player.name.." from corpse.")
        end
    end
end

function x_sethealth(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_sethealth", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.health:SetPercent(num)
    end
end

function x_setmaxhealth(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setmaxhealth", true)
        if type(num) ~= "number" then
            num = 100
        end
        player.components.health:SetMaxHealth(num)
        player.components.health:SetPercent(1)
    end
end

function x_setminhealth(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setminhealth", true)
        if type(num) ~= "number" then
            num = 0
        end
        player.components.health:SetMinHealth(num)
    end
end

function x_setpenalty(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.health ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setpenalty", true)
        if type(num) ~= "number" then
            num = 0
        end
        player.components.health:SetPenalty(num)
        player.components.health:SetPercent(1)
    end
end

function x_setsanity(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.sanity ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setsanity", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.sanity:SetPercent(num)
    end
end

function x_setmaxsanity(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.sanity ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setmaxsanity", true)
        if type(num) ~= "number" then
            num = 100
        end
        player.components.sanity:SetMax(num)
        player.components.sanity:SetPercent(1)
    end
end

function x_sethunger(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.hunger ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_sethunger", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.hunger:SetPercent(num)
    end
end

function x_setmaxhunger(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.hunger ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setmaxhunger", true)
        if type(num) ~= "number" then
            num = 100
        end
        player.components.hunger:SetMax(num)
        player.components.hunger:SetPercent(1)
    end
end

function x_pausehunger(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.hunger ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_pausehunger", true)
        if type(mode) ~= "boolean" then
            mode = player.components.health:IsPaused()
        end
        player.components.hunger.burning = not mode
    end
end

function x_setbeaverness(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.beaverness ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setbeaverness", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.beaverness:SetPercent(num)
    end
end

function x_setmoisture(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.moisture ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setmoisture", true)
        if type(num) ~= "number" then
            num = 0
        end
        player.components.moisture:SetPercent(num)
    end
end

function x_setmoisturelevel(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.moisture ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setmoisturelevel", true)
        if type(num) ~= "number" then
            num = 0
        end
        player.components.moisture:SetMoistureLevel(num)
    end
end

function x_settemperature(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.temperature ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_settemperature", true)
        if type(num) ~= "number" then
            num = 25
        end
        player.components.temperature:SetTemperature(num)
    end
end

function x_pausetemperature(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.temperature ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_pausetemperature", true)
        if type(mode) ~= "boolean" then
            mode = player.components.temperature.settemp == nil
        end
        local t = mode and player.components.temperature:GetCurrent() or nil
        player.components.temperature:SetTemp(player.components.temperature:GetCurrent())
    end
end

function x_setbuff(inst)
    local player = GetPlayer(inst)
    if player ~= nil and not player:HasTag("playerghost") then
        SuUsed("x_setbuff", true)
        local num = 500
        if player.components.health ~= nil then
            player.components.health:SetMaxHealth(num)
            player.components.health:SetPercent(1)
        end
        if player.components.sanity ~= nil then
            player.components.sanity:SetMax(num)
            player.components.sanity:SetPercent(1)
        end
        if player.components.hunger ~= nil then
            player.components.hunger:SetMax(num)
            player.components.hunger:SetPercent(1)
        end
    end
end

function x_godmode(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil then
        SuUsed("x_godmode", true)
        if player:HasTag("playerghost") then
            player:PushEvent("respawnfromghost")
            print("Reviving "..player.name.." from ghost.")
            return
        elseif player:HasTag("corpse") then
            player:PushEvent("respawnfromcorpse")
            print("Reviving "..player.name.." from corpse.")
            return
        elseif player.components.health ~= nil then
            if type(mode) ~= "boolean" then
                mode = not player.components.health:IsInvincible()
            end
            player.components.health:SetInvincible(mode)
        end
    end
end

function x_supergodmode(inst, mode)
    local player = GetPlayer(inst)
    if player ~= nil then
        SuUsed("x_supergodmode", true)
        if player:HasTag("playerghost") then
            player:PushEvent("respawnfromghost")
            print("Reviving "..player.name.." from ghost.")
            return
        elseif player.components.health ~= nil then
            if type(mode) ~= "boolean" then
                mode = not player.components.health:IsInvincible()
            end
            player.components.health:SetInvincible(mode)
            c_sethealth(1)
            c_setsanity(1)
            c_sethunger(1)
            c_settemperature(25)
            c_setmoisture(0)
        end
    end
end

function x_hypergodmode(inst)
    local player = GetPlayer(inst)
    if player ~= nil then
        SuUsed("x_hypergodmode", true)
        local num = 1500
        if player:HasTag("playerghost") then
            player:PushEvent("respawnfromghost")
            print("Reviving "..player.name.." from ghost.")
        elseif player:HasTag("corpse") then
            player:PushEvent("respawnfromcorpse")
            print("Reviving "..player.name.." from corpse.")
        end
        if player.components.health ~= nil then
            player.components.health:SetInvincible(true)
            player.components.health:SetMaxHealth(num)
            player.components.health:SetPercent(1)
        end
        if player.components.sanity ~= nil then
            player.components.sanity:SetMax(num)
            player.components.sanity:SetPercent(1)
        end
        if player.components.hunger ~= nil then
            player.components.hunger:SetMax(num)
            player.components.hunger:SetPercent(1)
        end
        if player.components.moisture ~= nil then
            player.components.moisture:SetMoistureLevel(0)
        end
        if player.components.temperature ~= nil then
            player.components.temperature:SetTemperature(30)
        end
    end
end

function x_speedmult(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.locomotor ~= nil then
        SuUsed("x_speedmult", true)
        if type(num) ~= "number" then
            num = 1
        end
        player.components.locomotor:SetExternalSpeedMultiplier(player, "c_speedmult", num)
    end
end

-- Put an item(s) in the player's inventory
function x_give(inst, prefab, count, dontselect)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.inventory ~= nil then
        for i = 1, count or 1 do
            local item = DebugSpawn(prefab)
            if item ~= nil then
                print("giving ", item)
                player.components.inventory:GiveItem(item)
                if not dontselect then
                    SetDebugEntity(item)
                end
                SuUsed("x_give_"..item.prefab)
            end
        end
    end
end

function x_removeslot(inst, num)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.inventory ~= nil then
        SuUsed("x_removeslot", true)
        player.components.inventory:RemoveItemBySlot(num)
    end
end

function x_dropeverything(inst)
    local player = GetPlayer(inst)
    if player ~= nil and player.components.inventory ~= nil then
        SuUsed("x_dropeverything", true)
        player.components.inventory:DropEverything()
    end
end

-- move inst or current player to dest
function x_goto(dest, inst)
    dest = GetPlayer(dest)
    inst = GetPlayer(inst)
    if inst ~= nil then
        SuUsed("x_goto", true)
        if dest ~= nil then
            if inst.Physics ~= nil then
                inst.Physics:Teleport(dest.Transform:GetWorldPosition())
            else
                inst.Transform:SetPosition(dest.Transform:GetWorldPosition())
            end
            
            return dest
        else
            inst.Transform:SetPosition(ConsoleWorldPosition():Get())
        end
    end
end

-- move inst to dest or current player
function x_move(inst, dest)
    dest = GetPlayer(dest)
    inst = GetPlayer(inst)
    if inst ~= nil then
        SuUsed("x_move", true)
        if dest ~= nil then
            if inst.Physics ~= nil then
                inst.Physics:Teleport(dest.Transform:GetWorldPosition())
            else
                inst.Transform:SetPosition(dest.Transform:GetWorldPosition())
            end
            return dest
        else
            inst.Transform:SetPosition(ConsoleWorldPosition():Get())
        end
    end
end

function x_revealmap(inst, num, int)
    local player = GetPlayer(inst)
    if player ~= nil then
        SuUsed("x_revealmap", true)
        if type(num) ~= "number" then
            num = 1600
        end
        if type(int) ~= "number" then
            int = 35
        end
        for x = -num, num, int do
            for y = -num, num, int do
                player.player_classified.MapExplorer:RevealArea(x, 0, y)
            end
        end
    end
end

-- World Commands
function x_nextcycle(count)
    SuUsed("x_nextcycle", true)
    for i = 1, count or 1 do
        TheWorld:PushEvent("ms_nextcycle")
    end
end

function x_nextphase(count)
    SuUsed("x_nextphase", true)
    for i = 1, count or 1 do
        TheWorld:PushEvent("ms_nextphase")
    end
end

function x_setphase(phase)
    SuUsed("x_setphase", true)
    if type(phase) == "number" then
        if phase == 1 then phase = "day"
        elseif phase == 2 then phase = "dusk"
        elseif phase == 3 then phase = "night"
        end
    end
    TheWorld:PushEvent("ms_setphase", phase)
end

function x_setseason(season)
    SuUsed("x_setseason", true)
    if type(season) == "number" then
        if season == 1 then season = "autumn"
        elseif season == 2 then season = "winter"
        elseif season == 3 then season = "spring"
        elseif season == 4 then season = "summer"
        end
    end
    TheWorld:PushEvent("ms_setseason", season)
end

function x_setrain(mode)
    SuUsed("x_setrain", true)
    TheWorld:PushEvent("ms_forceprecipitation", mode)
end



