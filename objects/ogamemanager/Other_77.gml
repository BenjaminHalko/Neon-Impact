/// @desc Start Game

if rollback_event_param.first_start {
	oGlobalManager.playerNum = rollback_event_param.player_id;
	global.numPlayers = max(global.numPlayers,oGlobalManager.playerNum+1);

	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				if _result.data.avatarUrl != "" {
					if global.multiplayer rollback_chat(_result.data.avatarUrl);
					else {
						global.names = array_create(4,_result.data.username);
						global.playerSprites[oGlobalManager.playerNum][0] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
					}
				}
			} 
		} catch(_error) { 
			show_debug_message(_error);
		}
	});

	if global.numPlayers == 1 {
		global.playersConnected = array_create(4,false);
		oGlobalManager.playerNum = irandom(3);
		global.names = array_create(4,"PLAYER 1");
		global.multiplayer = false;
		rollback_leave_game();
	}
	
	global.playersConnected[oGlobalManager.playerNum] = true;
}