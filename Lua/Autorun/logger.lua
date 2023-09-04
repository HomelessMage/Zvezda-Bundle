Hook.Add("client.connected", "loggerFunction", function (client)
    local msg = "Игрок подключился к серверу" .. "\n" .. "[Никнейм]: " .. client.Name .. "\n" ..  "[SteamID]: " .. client.SteamID .."\n"
    print(msg)
end)