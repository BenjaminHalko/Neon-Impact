/// @desc Initialize Multiplayer

if global.multiplayer {
	try {
		rollback_use_manual_start();
		
		rollback_define_input({
			mouseLeft: mb_left,
			mouseX: m_axisx_gui,
			mouseY: m_axisy_gui
		});
		
		var _test = os_type != os_operagx;

		if !rollback_join_game() {
			rollback_create_game(4,_test);
		}
		if _test {
			global.playersConnected = array_create(4,true);
			global.numPlayers = 4;
			oTitle.connected = true;
		}
	} catch(_error) {
		show_debug_message(_error);
		global.multiplayer = false;
	}
}

if !global.multiplayer {
	oGlobalManager.playerNum = irandom(3);
	global.playersConnected[oGlobalManager.playerNum] = true;
	global.names = array_create(4,"PLAYER 1");
	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				global.names = array_create(4,_result.data.username);
				global.playerSprites[oGlobalManager.playerNum][0] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
			} 
		} catch(_error) { 
			show_debug_message(_error);
		}
	});
}

global.roundStart = false;

global.scores = array_create(4,0);
global.time = 0;

global.spectate = noone;
spectatorNumber = 0;

rollbackSubtrackFrame = 0;

tanAngle = darctan(540/960);

//GameOver
global.gameOver = false;
stopTimer = false;
alone = false;

panelXPercent = -0.5;
recordPercent = 0;
hexPercent = 0;
textPercent = 0;
timeLeft = 10;
leave = false;

xMoveCurve = animcurve_get_channel(GameOverCurve,"xMove");
yHexCurve = animcurve_get_channel(GameOverCurve,"yHex");
xRecordCurve = animcurve_get_channel(GameOverCurve,"xRecord");

defaultIconSize = sprite_get_width(sDefaultIcons);
winOrder = [0,1,2,3];

//Transition
transitionPercent = 0;
transitionSurfacePing = -1;
transitionSurfacePong = surface_create(1920,1080);
transitionChange = false;
transitionDir = 0;