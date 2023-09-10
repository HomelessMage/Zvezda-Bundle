Hook.Add("client.connected", "logConnections", function (client)
    local msg = "Игрок подключился к серверу" .. "\n" .. "[Никнейм]: " .. client.Name .. "\n" ..  "[SteamID]: " .. client.SteamID .."\n"
    print(msg)
end)


-- Hook.Add('character.death', 'logDeaths', function(character)
--     print('Персонаж погиб: ', character.Name, 'Убийца: ', character.Info.CauseOfDeath.Attacker.Name)
-- end)