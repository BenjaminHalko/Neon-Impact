/// @desc Initialize Non-Synced Variables

#macro FRIC 0.125
#macro CamX oCamera.camX
#macro CamY oCamera.camY
#macro CamW oCamera.camW
#macro CamH oCamera.camH
#macro CamXReal camera_get_view_x(oCamera.cam)
#macro CamYReal camera_get_view_y(oCamera.cam)
#macro PAUSE ((global.multiplayer and !rollback_game_running))
#macro SYNC (!global.multiplayer or rollback_sync_on_frame())
#macro SPECTATING GLOBAL.spectateMode[oGlobalManager.playerNum]
#macro GLOBAL oGameManager
#macro SAVEFILE "save.ini"
#macro SYNCTEST false

#macro CHALLENGEID "d655ef5e-ed52-4228-ac58-292edf12ec3d"

randomize();

qualitySign = 0;

global.operaGX = os_type == os_operagx;
global.mobile = os_type == os_android;
global.isBrowser = !global.operaGX and os_browser != browser_not_a_browser;

global.resW = 1920;
global.resH = 1080;

instance_create_layer(0,0,"Render",oRender);

global.title = true;
global.colours = [ #00FFFF, #FF0048, #55FF00, #FF9C00, #5500FF ];
global.multiplayer = false;
global.playerSprites = array_create(4,noone);

for (var i = 0; i < 4; i++) {
	global.playerSprites[i] = [noone,noone];
}

playerNum = 0;

number = 0;
maxNum = 12;

globalScores = []
ownGlobalScore = -1;

audioPlaying = ds_map_create();

ini_open(SAVEFILE);
musicVol = ini_read_real("audio","bgm",0.75);
sfxVol = ini_read_real("audio","sfx",1.5);
ini_close();

switchedToSinglePlayer = false;

transitionSurfacePing = surface_create(1920,1080);
transitionSurfacePong = surface_create(1920,1080);

musicLastPos = 0;
bumperScale = [0,0];
music = noone;

windowW = 1920;
windowH = 1080;

try {
	gxc_challenge_get_global_scores(function(_status, _result) {
		try {
			if (_status == 200) {
				for(var i = 0; i < array_length(_result.data.scores); i++) {
					array_push(globalScores,{
						username: _result.data.scores[i].player.username,
						sprite: sprite_add(_result.data.scores[i].player.avatarUrl,0,false,false,0,0),
						points: _result.data.scores[i].score/1000
					});	
				}
			} 
		} catch(_error) { 
			show_debug_message(_error);
		}
	},{
		challengeId: CHALLENGEID,
		pageSize: 3,
		page: 0
	});
} catch (_error) {
	show_debug_message(_error);	
}

if !global.operaGX {
	ini_open(SAVEFILE);
	globalScores = [{
		username: "PLAYER 1",
		sprite: noone,
		points: ini_read_real("scores","0",60)
	},{
		username: "PLAYER 1",
		sprite: noone,
		points: ini_read_real("scores","1",30)
	},{
		username: "PLAYER 1",
		sprite: noone,
		points: ini_read_real("scores","2",15)
	}];
	ini_close();
}

instance_create_layer(0,0,layer,oTitle);