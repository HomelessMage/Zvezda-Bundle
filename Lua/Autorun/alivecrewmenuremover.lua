if CLIENT then return end

local botGod
local setClientCharacterToNil = {}

local function clientChar(char)
    local clients = Client.ClientList

    for key, client in pairs(clients) do
        if (client.Character == char) then return client end
    end

    return nil
end

Hook.Add("roundStart", "crewmenuRoundStart", function ()
    for key, value in pairs(Client.ClientList) do
        if value.Character ~= nil then
            value.Character.TeamID = CharacterTeamType.FriendlyNPC
        end
    end
    -- local info = CharacterInfo(Identifier("human"), "God Himself")
    
    -- botGod = Character.Create(info, Vector2.Zero, info.Name, 0, true, false)
    -- botGod.GodMode = true
    -- botGod.TeamID = CharacterTeamType.FriendlyNPC
end)

Hook.Add("roundEnd", "crewmenuRoundEnd", function ()
    setClientCharacterToNil = {}
end)

Hook.Add("characterDeath", "crewmenuRemoveDeath", function (character)
    if not character.IsHuman or character.IsBot then return end

    local client = clientChar(character)

    if client == nil then return end

    client.SetClientCharacter(botGod)

    setClientCharacterToNil[client] = Timer.GetTime() + 0.5
end)

Hook.Add("think", "crewmenuTimer", function ()
    for key, value in pairs(setClientCharacterToNil) do
        if Timer.GetTime() > value then
            key.SetClientCharacter(nil)

            setClientCharacterToNil[key] = nil
        end
    end
end)


Hook.Add("chatMessage", "crewmenu_chatcommands", function(msg, client)

    if msg == "!игроки" then
        if client.Character == nil or client.Character.IsDead == true or bit32.band(client.Permissions, 0x40) == 0x40 then

            local msg = ""
            for key, value in pairs(Character.CharacterList) do

                if value.IsHuman and not value.IsBot then
                    print(value.IsDead)
                    if value.IsDead then
                        msg = msg .. "[МЕРТВ] " .. value.name .. "\n"
                    else
                        msg = msg .. "[ЖИВ] " .. value.name .. "\n"
                    end
                end
            end

            -- Game.SendDirectChatMessage("", msg, nil, 7, client)
            Game.SendDirectChatMessage("", msg, nil, 1, client)

            return true
        end

    end
end)
