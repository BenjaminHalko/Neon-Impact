/// @desc Initialize Multiplayer

GLOBAL.camZoom = 0;
GLOBAL.numPlayers = 1;
GLOBAL.names = ["PLAYER 1","PLAYER 2", "PLAYER 3", "PLAYER 4"];
GLOBAL.playersConnected = [false,false,false,false];

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
			GLOBAL.playersConnected = array_create(4,true);
			GLOBAL.numPlayers = 4;
			oTitle.connected = true;
		}
	} catch(_error) {
		show_debug_message(_error);
		global.multiplayer = false;
	}
}

if !global.multiplayer {
	oGlobalManager.playerNum = irandom(3);
	GLOBAL.playersConnected[oGlobalManager.playerNum] = true;
	GLOBAL.names = array_create(4,"PLAYER 1");
	gxc_profile_get_info(function(_status, _result) {
		try {
			if (_status == 200) {
				GLOBAL.names = array_create(4,_result.data.username);
				global.playerSprites[oGlobalManager.playerNum][0] = sprite_add(_result.data.avatarUrl,0,false,false,0,0);
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
}

GLOBAL.roundStart = false;

GLOBAL.scores = array_create(4,0);
GLOBAL.time = 0;

GLOBAL.spectate = noone;
spectatorNumber = 0;

tanAngle = darctan(540/960);

//GameOver
GLOBAL.gameOver = false;
stopTimer = false;
alone = false;

panelXPercent = -0.5;
recordPercent = 0;
hexPercent = 0;
textPercent = 0;
timeLeft = 8;
leave = false;

camPositionsX = array_create(4,0);
camPositionsY = array_create(4,0);

xMoveCurve = animcurve_get_channel(GameOverCurve,"xMove");
yHexCurve = animcurve_get_channel(GameOverCurve,"yHex");
xRecordCurve = animcurve_get_channel(GameOverCurve,"xRecord");

defaultIconSize = sprite_get_width(sDefaultIcons);
winOrder = [0,1,2,3];

gotScores = array_create(4,false);

//Transition
transitionPercent = 1;
transitionChange = false;
transitionDir = 0;