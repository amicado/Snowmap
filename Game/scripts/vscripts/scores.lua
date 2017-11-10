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

    return scores;
    
end