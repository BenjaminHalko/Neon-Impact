/// @desc Initialize Non-Synced Variables

#macro FRIC 0.125
#macro CamX oCamera.camX
#macro CamY oCamera.camY
#macro CamW oCamera.camW
#macro CamH oCamera.camH
#macro CamXReal camera_get_view_x(oCamera.cam)
#macro CamYReal camera_get_view_y(oCamera.cam)
#macro PAUSE (global.multiplayer and !rollback_game_running)
#macro SYNC (!global.multiplayer or rollback_sync_on_frame())

#macro CHALLENGEID "d655ef5e-ed52-4228-ac58-292edf12ec3d"

global.colours = [ #00FFFF, #FF0048, #55FF00, #FF9C00, #5500FF ];
global.multiplayer = false;

global.camZoom = 0;
global.numPlayers = 1;
global.names = ["PLAYER 1","PLAYER 2", "PLAYER 3", "PLAYER 4"];
global.playerSprites = array_create(4,noone);
global.playersConnected = [false,false,false,false];

for (var i = 0; i < 4; i++) {
	global.playerSprites[i] = [noone,noone];
}

playerNum = 0;

number = 0;
maxNum = 12;

globalScores = []

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