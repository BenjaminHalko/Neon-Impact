/// @desc Initialize Non-Synced Variables

#macro FRIC 0.15
#macro CamX oCamera.camX
#macro CamY oCamera.camY
#macro CamW oCamera.camW
#macro CamH oCamera.camH
#macro PAUSE (global.multiplayer and !rollback_game_running)
#macro SYNC (!global.multiplayer or rollback_sync_on_frame())

#macro CHALLENGEID "d655ef5e-ed52-4228-ac58-292edf12ec3d"

global.colours = [ #00FFFF, #FF0048, #55FF00, #FF9C00, #5500FF ];
global.multiplayer = true;

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

instance_create_layer(0,0,layer,oGameManager);