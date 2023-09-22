if CLIENT then return end

-- local botGod
-- local setClientCharacterToNil = {}

-- local function clientChar(char)
--     local clients = Client.ClientList

--     for key, client in pairs(clients) do
--         if (client.Character == char) then return client end
--     end

--     return nil
-- end

-- Hook.Add("roundStart", "crewmenuRoundStart", function ()
--     for key, value in pairs(Client.ClientList) do
--         if value.Character ~= nil then
--             value.Character.TeamID = CharacterTeamType.Team1
--         end
--     end
-- end)

-- Hook.Add("character.created", "characterCreated", function ()
--     for key, value in pairs(Client.ClientList) do
--         if value.Character ~= nil then
--             value.Character.TeamID = CharacterTeamType.Team1
--         end
--     end
-- end)

-- Hook.Add("roundEnd", "crewmenuRoundEnd", function ()
--     setClientCharacterToNil = {}
-- end)

-- Hook.Add("characterDeath", "crewmenuRemoveDeath", function (character)
--     if not character.IsHuman or character.IsBot then return end

--     local client = clientChar(character)

--     if client == nil then return end

--     client.SetClientCharacter(botGod)

--     setClientCharacterToNil[client] = Timer.GetTime() + 0.5
-- end)

-- Hook.Add("think", "crewmenuTimer", function ()
--     for key, value in pairs(setClientCharacterToNil) do
--         if Timer.GetTime() > value then
--             key.SetClientCharacter(nil)

--             setClientCharacterToNil[key] = nil
--         end
--     end
-- end)


Hook.Add("chatMessage", "crewmenu_chatcommands", function(msg, client)

    if msg ~= "!игроки" then return end
    if bit32.band(client.Permissions, 0x40) == 0x40 then
        local msg = ""
        -- you have to loop through Client.ClientList do find the client that is controlling the character, or use Util.FindClientCharacter(character)
        for player in Client.ClientList do
            -- print(player.Name .. player.Character.Name)
            if player.Character.IsHuman then
                    msg = msg .. "\n" .. "[Живой персонаж]: " .. player.Character.Name .. "\n" .. "[Никнейм]: " .. player.Name .. "\n" ..  "[SteamID]: " .. player.SteamID .."\n"
            end
        end
        for character in Character.CharacterList do
            if character.IsHuman and character.IsDead and not character.IsBot then
                msg = msg .. "\n" .. "[Мертвый персонаж]: " .. character.Name .. "\n"
            end
        end



        -- Game.SendDirectChatMessage("", msg, nil, 7, client)
        -- В консоль
        print(msg)
        -- Game.SendDirectChatMessage("", msg, nil, 6, client)
        -- В чат
        -- Game.SendDirectChatMessage("", msg, nil, 1, client)
        -- Game.SendDirectChatMessage("", msg, nil, 2, client)

        -- Game.SendDirectChatMessage("", msg, nil, 3, client)

        
        -- GameServer.Log("msg", ServerLog.MessageType.Attack)


        return true
    end
end)


-- Hook.Add("think", "logtimer", function()
--     if basicTimer > Timer.GetTime() then return end -- skip code below
    
--     basicTimer = Timer.GetTime() + 1                -- timer runs every 5 seconds
--     local ratelimiter = 0
--     for key, value in pairs(loglist) do
--       ratelimiter = ratelimiter + 1
--       if discordhook ~= "https://discord.com/api/webhooks/1099761629534638122/D-WBDacyd5_ryRehnFSINlcFpKsSc8VOx3d9JD8PxysIgIhrw1n8wYqcBGGPan_xH0WT" then
--         Networking.RequestPostHTTP(discordhook, function(result)
--         end, value)
--       end
--       if ratelimiter >= 5 then
--         break
--       end
--     end
--   end)
