if CLIENT then return end

local HasBeenSpawned = {}

Hook.Add("roundStart", "MidRoundSpawn.roundStart", function ()
    for key, client in pairs(Client.ClientList) do
        HasBeenSpawned[client.SteamID] = true
    end
end)

Hook.Add("clientConnected", "MidRoundSpawn.clientConnected", function (newClient)
    if Game.RoundStarted and HasBeenSpawned[newClient.SteamID] == nil then
        HasBeenSpawned[newClient.SteamID] = true
        -- Spawn character on main sub
        local firstNames = {"Александр", "Алексей", "Альберт", "Анатолий", "Андрей", "Антон", "Аркадий", "Арсений", "Артём", "Артур", "Афанасий", "Богдан", "Борис", "Вадим", "Валентин", "Валерий", "Василий", "Виктор", "Виталий", "Владимир", "Владислав", "Всеволод", "Вячеслав", "Геннадий", "Георгий", "Глеб", "Григорий", "Даниил", "Демид", "Демьян", "Денис", "Дмитрий", "Евгений", "Егор", "Иван", "Игорь", "Илья", "Кирилл", "Константин", "Лев", "Леонид", "Макар", "Максим", "Матвей", "Михаил", "Никита", "Николай", "Олег", "Павел", "Пётр", "Родион", "Роман", "Руслан", "Савелий", "Святослав", "Семён", "Сергей", "Станислав", "Степан", "Тимофей", "Тимур", "Фёдор", "Эдуард", "Юрий", "Ян"}
        local lastNames = {"Авдеев", "Агапов", "Агафонов", "Агеев", "Акимов", "Аксёнов", "Александров", "Алексеев", "Алёхин", "Алешин", "Алёшин", "Ананьев", "Андреев", "Андрианов", "Аникин", "Анисимов", "Анохин", "Антипов", "Антонов", "Артамонов", "Артёмов", "Архипов", "Астафьев", "Астахов", "Афанасьев", "Бабушкин", "Баженов", "Балашов", "Баранов", "Барсуков", "Басов", "Безруков", "Беликов", "Белкин", "Белов", "Белоусов", "Беляев", "Беляков", "Березин", "Берия", "Беспалов", "Бессонов", "Бирюков", "Блинов", "Блохин", "Бобров", "Богданов", "Богомолов", "Болдырев", "Большаков", "Бондарев", "Борисов", "Бородин", "Бочаров", "Булатов", "Булгаков", "Буров", "Быков", "Бычков", "Вавилов", "Васильев", "Вдовин", "Верещагин", "Вешняков", "Виноградов", "Винокуров", "Вишневский", "Владимиров", "Власов", "Волков", "Волошин", "Воробьёв", "Воронин", "Воронков", "Воронов", "Воронцов", "Второв", "Высоцкий", "Гаврилов", "Гайдуков", "Гакабов", "Галкин", "Герасимов", "Гладков", "Глебов", "Глухов", "Глушков", "Гноев", "Голиков", "Голованов", "Головин", "Голубев", "Гончаров", "Горбань", "Горбачав", "Горбачёв", "Горбунов", "Гордеев", "Горелов", "Горлов", "Горохов", "Горшков", "Горюнов", "Горячев", "Грачёв", "Греков", "Грибков", "Грибов", "Григорьев", "Гришин", "Громов", "Губанов", "Гуляев", "Гуров", "Гусев", "Гущин", "Давыдов", "Данилов", "Дашков", "Дегтярев", "Дегтярёв", "Дементьев", "Демидов", "Дёмин", "Демьянов", "Денисов", "Дмитриев", "Добрынин", "Долгов", "Дорофеев", "Дорохов", "Дроздов", "Дружинин", "Дубинин", "Дубов", "Дубровин", "Дьяков", "Дьяконов", "Евдокимов", "Евсеев", "Егоров", "Ежов", "Елизаров", "Елисеев", "Ельцин", "Емельянов", "Еремеев", "Ерёмин", "Ермаков", "Ермилов", "Ермолаев", "Ермолов", "Еромлаев", "Ерофеев", "Ерохин", "Ершов", "Ефимов", "Ефремов", "Жаров", "Жданов", "Жилин", "Жириновский", "Жуков", "Журавлёв", "Завьялов", "Зайцев", "Захаров", "Зверев", "Звягинцев", "Зеленин", "Зимин", "Зиновьев", "Злобин", "Золотарев", "Золотарёв", "Золотов", "Зорин", "Зотов", "Зубков", "Зубов", "Зуев", "Зыков", "Зюганов", "Иванов", "Ивашов", "Игнатов", "Игнатьев", "Измайлов", "Ильин", "Ильинский", "Ильюхин", "Исаев", "Исаков", "Казаков", "Казанцев", "Калачев", "Калачёв", "Калашников", "Калинин"}
        local randomName = firstNames[math.random(#firstNames)] .. " " .. lastNames[math.random(#lastNames)]
        -- Note: If we plan only running this server-side, we could grab the CharacterInfo from client instead, which will have all their info already set, like name and hair style.
        -- local info = CharacterInfo("human", client.Name)
        local info = CharacterInfo("human", randomName)
        info.Job = Job(JobPrefab.Get("prisoner"))
    
        local submarine = Submarine.MainSub
        -- This method takes a list of CharacterInfo that it will use to choose the correct spawn waypoint
        -- in this case we only have a single info, so we just create a table with just that info in it.
        local spawnPoint = WayPoint.SelectCrewSpawnPoints({info}, submarine)[1]
    
        if spawnPoint == nil then
            -- we should probably do something if it isn't able to find a spawn point
        end
    
        local character = Character.Create(info, spawnPoint.WorldPosition, info.Name, 0, false, false)
        character.TeamID = CharacterTeamType.Team1
        -- Предположительно вызывает краши:
        -- character.TeamID = CharacterTeamType.FriendlyNPC
        character.GiveJobItems()
    
    
        if CLIENT then
            Character.Controlled = character
        else
            newClient.SetClientCharacter(character)
        end
        -- Логгирование
        print("Вселение в персонажа" .. "\n" .. "[Никнейм]: " .. newClient.Name .. "\n" .. "[Имя персонажа]: " .. randomName .. "\n" .. "[SteamID]: " .. newClient.SteamID)
    end
end)