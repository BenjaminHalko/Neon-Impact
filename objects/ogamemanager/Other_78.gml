/// @desc Get User URL + Number of Players + Disconnect Players

if (rollback_event_id == rollback_chat_message) {
	var _url = rollback_event_param.message;
	var _num = rollback_event_param.from;
	if string_char_at(_url,1) == "h" global.playerSprites[_num][0] = sprite_add(_url,0,false,false,0,0);
	else {
		global.scores[_num] = real(_url);
		gotScores[_num] = true;
		if _num != oGlobalManager.playerNum {
			with(oPlayer) {
				if !dead and index == _num DefeatPlayer(_num);
			}
		}
	}
} else if (rollback_event_id == rollback_synchronizing_with_peer) {
	var _id = rollback_event_param.player_id;
	global.numPlayers = max(global.numPlayers,_id+1);
	global.playersConnected[_id] = true;
} else if (rollback_event_id == rollback_disconnected_from_peer) {
	var _id = rollback_event_param.player_id;
	global.playersConnected[_id] = false;
	if room == rGame {
		global.numPlayers--;
		global.scores[_id] = global.time;
		gotScores[_id] = true;
		DefeatPlayer(_id,true);
	}
} else if (rollback_event_id == rollback_connect_error) {
	global.multiplayer = false;
	oGlobalManager.playerNum = irandom(3);
	global.playersConnected[oGlobalManager.playerNum] = true;
	global.names = array_create(4,"PLAYER 1");
	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				global.names[oGlobalManager.playerNum] = _result.data.username;
				global.playerSprites[oGlobalManager.playerNum] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
			} 
		} catch(_error) { 
			show_debug_message(_error);
		}
	});
} else if (rollback_event_id == rollback_game_info and room == rTitle) {
	oTitle.connected = true;
	var _id = rollback_event_param.player_id;
	global.numPlayers = max(global.numPlayers,_id+1);
	global.playersConnected[_id] = true;
}