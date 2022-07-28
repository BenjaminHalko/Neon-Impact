/// @desc Initialize Multiplayer

global.names = ["PLAYER 1","PLAYER 2", "PLAYER 3", "PLAYER 4"];
global.playerSprites = array_create(4,0);
for (var i = 0; i < 4; i++) {
	global.playerSprites[i] = [noone,noone];
}

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
		} catch(_error) { 
			show_debug_message(_error);
		}
	});
}

global.scores = array_create(4,0);
global.time = 0;
global.spectate = noone;
global.gameOver = false;
spectatorNumber = 0;

stopTimer = false;
tanAngle = darctan(540/960);

//GameOver
panelXPercent = -0.5;
recordPercent = 0;
hexPercent = 0;

textPercent = 0;

leave = false;

xMoveCurve = animcurve_get_channel(GameOverCurve,"xMove");
hexYCurve = animcurve_get_channel(GameOverCurve,"HexY");
xRecordCurve = animcurve_get_channel(GameOverCurve,"xRecord");

defaultIconSize = sprite_get_width(sDefaultIcons);

winOrder = [0,1,2,3];


//Debug
restart = false;

