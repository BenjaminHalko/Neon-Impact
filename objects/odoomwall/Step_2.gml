/// @desc Move Wall

if PAUSE exit;

if !surface_exists(surface) surface = surface_create(1920,1080);

if !GLOBAL.roundStart {
	if !surface_exists(fullScreenSurface) {
		fullScreenSurface = surface_create(room_width,room_height);
		drawWall(0,0,fullScreenSurface,room_width,room_height);
	}
	exit;
}

if GLOBAL.gameOver {
	rotation -= 0.1;
	disappear = Approach(disappear,50,1);
	wallLen = Approach(wallLen,-70,disappear);
	exit;
}

#region Collision
wallLen = lerp(minLen,maxLen,animcurve_channel_evaluate(curve,wallPercent));

if !debug {
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
			PlayAudio(snDeath,0.15,x,y);
			
			deadObject = instance_create_layer(x,y,"Dead",oPlayerDeath);
			with deadObject {
				index = other.index;
				image_angle = other.image_angle;
			}
			
			var _num = 0;
			with(oPlayer) {
				if visible _num++
			}
			
			if _num == 2 and !instance_exists(oBot) {
				with(instance_create_layer(oDoomWall.x,oDoomWall.y,"Players",oBot)) scale = 0;
			}

			var _dir = ((360 + point_direction(other.x,other.y,x,y) - other.rotation) % 360 div 60) * 60 + other.rotation % 360 - 150;
			for(var i = -1; i <= 1; i++) {
				with(instance_create_layer(x,y,"Projectiles",oProjectile)) {
					created = true;
					noProjectileCollision = true;
					image_angle = other.image_angle;
					colour = global.colours[other.index];
					colourAmount = 1;
					hSpd = lengthdir_x(13,_dir+45*i);
					vSpd = lengthdir_y(13,_dir+45*i);
					image_xscale = 64/sprite_width;
					image_yscale = image_xscale;
					mass = 64/96;
				}
			}
			
			visible = false;
		
			GLOBAL.scores[index] = GLOBAL.time;
			
			if player_local {
				try { gxc_challenge_submit_score(GLOBAL.time*1000,undefined,{challengeId: CHALLENGEID}); }
				catch(_error) { show_debug_message(_error); }
			}
		
			if _num <= 1 {
				oGameManager.stopTimer = true;
				audio_stop_sound(mMusic);
			}
		}
	}
} else {
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
}

with(oProjectile) {
	if colour == c_white continue;
	
	var _collide = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(other.wallLen,i*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,i*360/6+other.rotation),other.x+lengthdir_x(other.wallLen,(i+1)*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,(i+1)*360/6+other.rotation)) {
			_collide = false;
			outSideOfWall = true;
			break;
		}
	}
	
	if !_collide or ((!outSideOfWall or other.wallLen < 1000) and object_index != oBot) continue;
	if _collide outSideOfWall = false;
	
	var _angle = ((360 + point_direction(other.x,other.y,x,y) - other.rotation) % 360 div 60) * 60 + other.rotation % 360 - 150;

	var _spd = point_distance(0,0,hSpd,vSpd);
	var _dir = point_direction(0,0,hSpd,vSpd);
	_dir += angle_difference(_dir, _angle) * 2 * sign(_angle - _dir) - 180;
	
	if _spd < 10 {
		_spd = 20;
		_dir = _angle;
	}
	
	while(_collide) {
		x += lengthdir_x(1,_angle);
		y += lengthdir_y(1,_angle);
		
		for(var i = 0; i < 6; i++) {
			if point_in_triangle(x,y,other.x,other.y,other.x+lengthdir_x(other.wallLen,i*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,i*360/6+other.rotation),other.x+lengthdir_x(other.wallLen,(i+1)*360/6+other.rotation),other.y+lengthdir_y(other.wallLen,(i+1)*360/6+other.rotation)) {
				_collide = false;
				break;
			}
		}	
	}
	
	hSpd = lengthdir_x(_spd,_dir);
	vSpd = lengthdir_y(_spd,_dir);
}
#endregion

#region Moving
rotation -= 0.1;
var _num = -1;
with(oPlayer) {
	if visible _num++;
}
if !oGameManager.stopTimer wallPercent = Approach(wallPercent,in,0.001);
if wallPercent == in and SYNC {
	in = !in;
	xstart = x;
	ystart = y;
	if in {
		maxLen = max(maxLen-290+30*max(0,_num),maxLenMax+150*max(0,_num));
		xTo = irandom_range(maxLen+100,room_width-maxLen-100);
		yTo = irandom_range(maxLen+100,room_height-maxLen-100);
	} else {
		minLen = max(minLen-310+30*max(0,_num),minLenMax+150*max(0,_num));
		xTo = irandom_range(minLen+100,room_width-minLen-100);
		yTo = irandom_range(minLen+100,room_height-minLen-100);
	}
}

x = lerp(xstart,xTo,1-abs(in-animcurve_channel_evaluate(curve,wallPercent)));
y = lerp(ystart,yTo,1-abs(in-animcurve_channel_evaluate(curve,wallPercent)));
#endregion