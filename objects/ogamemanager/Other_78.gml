/// @desc Get User URL + Number of Players + Disconnect Players

if (rollback_event_id == rollback_chat_message) {
	var _url = rollback_event_param.message;
	var _num = rollback_event_param.from;
	global.playerSprites[_num][0] = sprite_add(_url,0,false,false,0,0);
} else if (rollback_event_id == rollback_synchronizing_with_peer) {
	var _id = rollback_event_param.player_id;
	global.numPlayers = max(global.numPlayers,_id+1);
	global.playersConnected[_id] = true;
} else if (rollback_event_id == rollback_disconnected_from_peer) {
	var _id = rollback_event_param.player_id;
	global.playersConnected[_id] = false;
	global.numPlayers--;
	
	if room == rGame {
		with(oPlayer) {
			if index == _id {
				deadObject = instance_create_layer(x,y,"Dead",oPlayerDeath);
				with deadObject {
					index = other.index;
					image_angle = other.image_angle;
				}
				
				var _dir = random(360);
				for(var i = 0; i < 3; i++) {
					with(instance_create_layer(x,y,"Projectiles",oProjectile)) {
						noProjectileCollision = true;
						image_angle = other.image_angle;
						colour = global.colours[other.index];
						colourAmount = 1;
						hSpd = lengthdir_x(12,_dir+120*i);
						vSpd = lengthdir_y(12,_dir+120*i);
						image_xscale = 64/sprite_width;
						image_yscale = image_xscale;
						mass = 64/96;
					}
				}
				visible = false;
		
				global.scores[index] = global.time;
				
				break;
			}
		}
	}
}