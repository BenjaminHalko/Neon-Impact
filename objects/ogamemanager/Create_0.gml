/// @desc Initialize Multiplayer

global.names = ["PLAYER 1","PLAYER 2", "PLAYER 3", "PLAYER 4"];
global.playerSprites = array_create(4,undefined);

if global.multiplayer {
	try {
		rollback_define_input({
			mouseLeft: mb_left,
			mouseX: m_axisx_gui,
			mouseY: m_axisy_gui
		});

		rollback_define_player(oPlayer);

		if !rollback_join_game() {
			rollback_create_game(4,true);	
		}
	} catch(_error) {
		show_debug_message(_error);
		global.multiplayer = false;
	}
}

if !global.multiplayer {
	instance_create_layer(room_width/2,room_height/2,"Instances",oPlayer,{
		player_local: true,
		player_id: 0
	});
	
	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				global.names[0] = _result.data.username;
				global.playerSprites[0] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
			} 
		} catch(_error) { show_debug_message(_error); }
	})
}

global.scores = array_create(4,0);
global.time = 0;
global.spectate = noone;
global.gameOver = false;
spectatorNumber = 0;

stopTimer = false;

//Debug
restart = false;

tanAngle = darctan(540/960);