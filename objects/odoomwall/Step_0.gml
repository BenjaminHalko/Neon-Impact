/// @desc

enableLive;

rotation -= 0.1;

wallPercent = 0.5;
if !surface_exists(surface) surface = surface_create(room_width,room_height);

var _len = maxLen*wallPercent;

with (oPlayer) {
	if disable or index != 0 continue;
	
	var _dead = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(_len - 45,i*360/6+other.rotation),other.y+lengthdir_y(_len - 45,i*360/6+other.rotation),other.x+lengthdir_x(_len - 45,(i+1)*360/6+other.rotation),other.y+lengthdir_y(_len - 45,(i+1)*360/6+other.rotation)) {
			_dead = false;
			break;
		}
	}
	
	if _dead and rollback_sync_on_frame() {
		deadObject = instance_create_layer(x,y,"Dead",oPlayerDeath);
		with deadObject {
			index = other.index;
			image_angle = other.image_angle;
		}
		for(var i = -1; i <= 1; i++) {
			with(instance_create_layer(x,y,"Projectiles",oProjectile)) {
				noProjectileCollision = true;
				image_angle = other.image_angle;
				colour = global.colours[other.index];
				colourAmount = 1;
				var _dir = point_direction(x,y,oDoomWall.x,oDoomWall.y)+45*i;
				hSpd = lengthdir_x(12,_dir);
				vSpd = lengthdir_y(12,_dir);
				image_xscale = 64/sprite_width;
				image_yscale = image_xscale;
				mass = 64/96;
			}
		}
		disable = true;
		
		if player_local {
			oGlobalManager.finalTime = global.time;
			oGameManager.scores[index] = global.time;

			try { gxc_challenge_submit_score(global.time*1000,undefined,{challengeId: CHALLENGEID}); }
			catch(_error) { show_debug_message(_error); }
		}
	}
}

with(oPlayer) {
	var _collide = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(_len,i*360/6+other.rotation),other.y+lengthdir_y(_len,i*360/6+other.rotation),other.x+lengthdir_x(_len,(i+1)*360/6+other.rotation),other.y+lengthdir_y(_len,(i+1)*360/6+other.rotation)) {
			_collide = false;
			break;
		}
	}
	
	if !_collide continue;
	
	var _angle = ((360 + point_direction(other.x,other.y,x,y) - other.rotation) % 360 div 60) * 60 + other.rotation % 360 - 150;

	hSpd = lengthdir_x(30,_angle);
	vSpd = lengthdir_y(30,_angle);
}

with(oProjectile) {
	if hSpd == 0 and vSpd == 0 continue;
	
	var _collide = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(_len,i*360/6+other.rotation),other.y+lengthdir_y(_len,i*360/6+other.rotation),other.x+lengthdir_x(_len,(i+1)*360/6+other.rotation),other.y+lengthdir_y(_len,(i+1)*360/6+other.rotation)) {
			_collide = false;
			break;
		}
	}
	
	if !_collide continue;
	
	var _angle = ((360 + point_direction(other.x,other.y,x,y) - other.rotation) % 360 div 60) * 60 + other.rotation % 360 - 150;

	var _spd = point_distance(0,0,hSpd,vSpd);
	var _dir = point_direction(0,0,hSpd,vSpd);
	_dir += angle_difference(_dir, _angle) * 2 * sign(_angle - _dir) - 180;
	
	hSpd = lengthdir_x(_spd,_dir);
	vSpd = lengthdir_y(_spd,_dir);
}