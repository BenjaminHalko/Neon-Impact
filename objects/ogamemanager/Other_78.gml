/// @desc Get User URL + Number of Players + Disconnect Players

if (rollback_event_id == rollback_chat_message) {
	var _url = rollback_event_param.message;
	var _num = rollback_event_param.from;
	global.playerSprites[_num][0] = sprite_add(_url,0,false,false,0,0);
} else if (rollback_event_id == rollback_synchronizing_with_peer) {
	var _id = rollback_event_param.player_id;
	GLOBAL.numPlayers = max(GLOBAL.numPlayers,_id+1);
	GLOBAL.playersConnected[_id] = true;
} else if (rollback_event_id == rollback_disconnected_from_peer) {
	var _id = rollback_event_param.player_id;
	GLOBAL.playersConnected[_id] = false;
	GLOBAL.numPlayers--;
	if !global.title {
		GLOBAL.scores[_id] = GLOBAL.time;
		DefeatPlayer(_id,true);
	} else {
		for(var i = 0; i < 4; i++) {
			if !GLOBAL.playersConnected[i] continue;
			if i == oGlobalManager.playerNum oTitle.host = true;
			break;
		}
	}
} else if (rollback_event_id == rollback_connect_error) {
	global.multiplayer = false;
	oGlobalManager.playerNum = irandom(3);
	GLOBAL.playersConnected[oGlobalManager.playerNum] = true;
	GLOBAL.names = array_create(4,"PLAYER 1");
	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				GLOBAL.names[oGlobalManager.playerNum] = _result.data.username;
				global.playerSprites[oGlobalManager.playerNum] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
				for(var i = 0; i < array_length(oGlobalManager.globalScores); i++) {
					if oGlobalManager.globalScores[i].username == _result.data.username {
						oGlobalManager.ownGlobalScore = i;
						break;
					}
				}
			} 
		} catch(_error) { 
			show_debug_message(_error);
		}
	});
} else if (rollback_event_id == rollback_game_info and global.title) {
	oTitle.connected = true;
	var _id = rollback_event_param.player_id;
	if _id != 0 oTitle.host = false;
	oGlobalManager.playerNum = _id;
	GLOBAL.numPlayers = max(GLOBAL.numPlayers,_id+1);
	GLOBAL.playersConnected[_id] = true;
}