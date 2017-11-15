function GetPlayerScores( playerID )
    print("GetPlayerScores");
    local scores = {}

    scores.name = PlayerResource:GetPlayerName(playerID);
    scores.steamid = PlayerResource:GetSteamAccountID(playerID);
    scores.heroname = PlayerResource:GetSelectedHeroName(playerID);
    scores.team = PlayerResource:GetTeam(playerID);
    scores.kills = PlayerResource:GetKills(playerID);
    scores.deaths = PlayerResource:GetDeaths(playerID);
    scores.assists = PlayerResource:GetAssists(playerID);

    return scores;

end

function GetGameScores()
    print("GetGameScores");
    local scores = {}

    scores.winner = WINNER;
    
    if tree_radiant then
        scores.tree_radiant = true;
    else
        scores.tree_radiant = false;
    end

    if tree_dire then
        scores.tree_dire = true;
    else
        scores.tree_dire = false;
    end

    if present_radiant then
        scores.present_radiant = true;
    else
        scores.present_radiant = false;
    end

    if present_dire then
        scores.present_dire = true;
    else
        scores.present_dire = false;
    end

    if ward_radiant then
        scores.ward_radiant = true;
    else
        scores.ward_radiant = false;
    end

    if ward_dire then
        scores.ward_dire = true;
    else
        scores.ward_dire = false;
    end


    return scores;
    
end