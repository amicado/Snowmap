function GetPlayerScores( playerID )
    print("GetPlayerScores");
    local scores = {}

    scores.name = PlayerResource:GetPlayerName(playerID);
    scores.gold = PlayerResource:GetGold(playerID);
    scores.kills = PlayerResource:GetKills(playerID);
    scores.deaths = PlayerResource:GetDeaths(playerID);
    scores.assists = PlayerResource:GetAssists(playerID);

    return scores;

end

function GetGameScores()
    print("GetGameScores");
    local scores = {}

    scores.radiantRoshanAlive = roshan_radiant:IsAlive()
    scores.direRoshanAlive = roshan_dire:IsAlive()

    return scores;
    
end