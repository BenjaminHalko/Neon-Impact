/// @desc Start Game

oGlobalManager.playerNum = rollback_event_param.player_id;

rollback_chat("https://play.gxc.gg/users/2af23458-45e6-4110-ab15-80165c3e9ae2?20dae8549c126b2e9f5ba599190dad49")
global.playerSprites[oGlobalManager.playerNum][0] = sprite_add("https://play.gxc.gg/users/2af23458-45e6-4110-ab15-80165c3e9ae2?20dae8549c126b2e9f5ba599190dad49",0,false,false,0,0);

gxc_profile_get_info(function(_status, _result) {
	try {
		if (_status == 200) {
			show_debug_message(_result.data.avatarUrl)
			if _result.data.avatarUrl != "" {
				if global.multiplayer rollback_chat(_result.data.avatarUrl);
				global.playerSprites[oGlobalManager.playerNum][0] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
			}
		} 
	} catch(_error) { 
		show_debug_message(_error);
	}
});

if instance_number(oPlayer) == 1 {
	global.multiplayer = false;
	rollback_leave_game();
}
	