/// @desc Move Wall

enableLive;

if PAUSE exit;

if !surface_exists(surface) surface = surface_create(room_width,room_height);

if global.gameOver {
	rotation -= 0.1;
	disappear = Approach(disappear,50,1);
	wallLen = Approach(wallLen,-70,disappear);
	exit;
}

#region Collision
wallLen = lerp(minLen,maxLen,animcurve_channel_evaluate(curve,wallPercent));

with (oPlayer) {
	if !visible continue;
	
	var _dead = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(other.wallLen - 45,i*360/6+other.rotation),other.y+lengthdir_y(other.wallLen - 45,i*360/6+other.rotation),other.x+lengthdir_x(other.wallLen - 45,(i+1)*360/6+other.rotation),other.y+lengthdir_y(other.wallLen - 45,(i+1)*360/6+other.rotation)) {
			_dead = false;
			break;
		}
	}
	
	if _dead and SYNC {
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
		visible = false;
		
		global.scores[index] = global.time;
		if player_local {
			try { gxc_challenge_submit_score(global.time*1000,undefined,{challengeId: CHALLENGEID}); }
			catch(_error) { show_debug_message(_error); }
		}
		
		oGameManager.stopTimer = true;
		with(oPlayer) {
			if visible {
				oGameManager.stopTimer = false;
				break;
			}
		}
	}
}

with(oPlayer) {
	var _collide = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(other.wallLen,i*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,i*360/6+other.rotation),other.x+lengthdir_x(other.wallLen,(i+1)*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,(i+1)*360/6+other.rotation)) {
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
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(other.wallLen,i*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,i*360/6+other.rotation),other.x+lengthdir_x(other.wallLen,(i+1)*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,(i+1)*360/6+other.rotation)) {
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
#endregion

#region Moving
rotation -= 0.1;
if !oGameManager.stopTimer wallPercent = Approach(wallPercent,in,0.001);
if wallPercent == in {
	in = !in;
	xstart = x;
	ystart = y;
	if in {
		maxLen = max(maxLen-100,maxLenMin);
		xTo = irandom_range(maxLen+100,room_width-maxLen-100);
		yTo = irandom_range(maxLen+100,room_height-maxLen-100);
	} else {
		minLen = max(minLen-100,minLenMin);
		xTo = irandom_range(minLen+100,room_width-minLen-100);
		yTo = irandom_range(minLen+100,room_height-minLen-100);
	}
}

x = lerp(xstart,xTo,1-abs(in-animcurve_channel_evaluate(curve,wallPercent)));
y = lerp(ystart,yTo,1-abs(in-animcurve_channel_evaluate(curve,wallPercent)));
#endregion