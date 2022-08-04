/// @desc Moves "a" towards "b" by "amount" and returns the result
/// @param {Real} a The value to change
/// @param {Real} b The target value
/// @param {Real} amount The amount to move by
/// @return {Real}
function Approach(_a, _b, _amount)
{
	if (_a < _b)
	{
		_a += _amount;
	    if (_a > _b)
	        return _b;
	}
	else
	{
	    _a -= _amount;
	    if (_a < _b)
	        return _b;
	}
	return _a;
}

/// @desc Moves a value to a target value with easing.
/// @param {Real} Value The target value
/// @param {Real} Target The target value
/// @param {Real} MaxSpd The maximum speed
/// @param {Real} Ease The ease amount from 0 - 1
/// @return {Real}
function ApproachFade(_value,_target,_maxSpd,_ease)
{
	_value += median(-_maxSpd,_maxSpd,(1-_ease)*(_target-_value));
	return _value
}

/// @desc Moves a value to a target value with easing, used for circles
/// @param {Real} Value The target value
/// @param {Real} Target The target value
/// @param {Real} MaxSpd The maximum speed
/// @param {Real} Ease The ease amount from 0 - 1
/// @return {Real}
function ApproachCircleEase(_value,_target,_maxSpd,_ease)
{
	_value += median(-_maxSpd,_maxSpd,(1-_ease)*angle_difference(_target,_value));
	return _value
}

/// @desc Turns {x} into a percent from {a} to {b}
/// @param {Real} x The value to turn into a percent
/// @param {Real} a The min value
/// @param {Real} b The max value
/// @return {Real}
function ValuePercent(_x, _a, _b) {
	return (_x - _a) / (_b - _a)
}

/// @desc Returns a value that will wave back and forth between [from-to] over [duration] seconds
/// @param {Real} from The minimum wave range
/// @param {Real} to The maximum wave range
/// @param {Real} duration The duration of the wave in seconds
/// @param {Real} offset The offset of the wave from 0 to 1
/// @return {Real}
function Wave(_from, _to, _duration, _offset) {
	var a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((global.multiplayer ? rollback_current_frame / 60 : current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

/// @desc Returns the value wrapped, values over or under will be wrapped around
/// @param {Real} value
/// @param {Real} min
/// @param {Real} max
/// @return {Real}
function Wrap(_value, _min, _max) {
	if (_value mod 1 == 0)
	{
	    while (_value > _max || _value < _min)
	    {
	        if (_value > _max)
	            _value += _min - _max - 1;
	        else if (_value < _min)
	            _value += _max - _min + 1;
	    }
	    return(_value);
	}
	else
	{
	    var _valueOld = _value + 1;
	    while (_value != _valueOld)
	    {
	        _valueOld = _value;
	        if (_value < _min)
	            _value = _max - (_min - _value);
	        else if (_value > _max)
	            _value = _min + (_value - _max);
	    }
	    return(_value);
	}

}

function RenderConverArt(_sprite) {
	var _surfacePing = surface_create(sprite_get_width(_sprite),sprite_get_height(_sprite));
	var _surfacePong = surface_create(sprite_get_width(_sprite),sprite_get_height(_sprite));

	surface_set_target(_surfacePing);
	draw_sprite(_sprite,0,0,0);
	surface_reset_target();

	surface_set_target(_surfacePong);
	shader_set(shBlur);
	shader_set_uniform_f(oRender.uBlurVector,0,1);
	draw_surface(_surfacePing,0,0);
	surface_reset_target();

	surface_set_target(_surfacePing);
	shader_set_uniform_f(oRender.uBlurVector,1,0);
	draw_surface_ext(_surfacePong,0,0,1,1,0,make_color_hsv(0,0,255*0.9),1);
	shader_reset();

	gpu_set_blendmode(bm_add);
	draw_sprite_ext(_sprite,0,0,0,1,1,0,make_color_hsv(0,0,255*0.55),1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	var _file = get_save_filename("*.png","CoverArt.png");
	surface_save(_surfacePing,_file);

	surface_free(_surfacePing);
	surface_free(_surfacePong);	
}

function ScreenShake(_magnitude, _length,_x=-1,_y=-1) {
	with (oCamera) {
		if (_x == -1 or point_in_rectangle(_x,_y,CamX,CamY,CamX+camW,CamY+camH)) and _magnitude > shakeRemain {
			shakeLength = _length;
			shakeMagnitude = _magnitude;
			shakeRemain = _magnitude;
		}
	}
}

function PlayAudio(_sound,_vol=1,_x=-1,_y=-1,_pitch=1) {
	if PAUSE return;
	if (_x == -1 or point_in_rectangle(_x,_y,CamX,CamY,CamX+CamW,CamY+CamH) or (object_index == oPlayer and (player_local or (GLOBAL.spectate == id and SPECTATING)))) and (!ds_map_exists(oGlobalManager.audioPlaying,id) or audio_get_name(oGlobalManager.audioPlaying[? id]) != audio_get_name(_sound)) {
		var _audio = audio_play_sound(_sound,1,false,_vol*oGlobalManager.sfxVol,0,_pitch);
		if ds_map_exists(oGlobalManager.audioPlaying,id) oGlobalManager.audioPlaying[? id] = _audio;
		else ds_map_add(oGlobalManager.audioPlaying,id,_audio);
	}
}

function HexagonSprite(_sprite) {
	var _maxSize = sprite_get_width(sDefaultIcons);
	var _width = sprite_get_width(_sprite);
	var _surface = surface_create(_maxSize,_maxSize);
	surface_set_target(_surface);
	draw_sprite(sDefaultIcons,4,0,0);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	draw_sprite_ext(_sprite,0,0,0,_maxSize/_width,_maxSize/_width,0,c_white,1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	var _sprite1 = sprite_create_from_surface(_surface,0,0,_maxSize,_maxSize,false,false,0,0);
	
	if object_index == oGlobalManager {
		sprite_delete(_sprite);
		surface_free(_surface);
		return _sprite1;
	}
	
	surface_set_target(_surface);
	draw_clear_alpha(c_black,0);
	draw_sprite_ext(sDefaultIcons,4,0,_maxSize,1,1,90,c_white,1);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	draw_sprite_ext(_sprite,0,0,0,_maxSize/_width,_maxSize/_width,0,c_white,1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	var _sprite2 = sprite_create_from_surface(_surface,0,0,_maxSize,_maxSize,false,false,0,0);
	
	sprite_delete(_sprite);
	surface_free(_surface);
	return [_sprite1,_sprite2];
}

function Transition(_change = false) {
	if !SYNC exit;
	with(oGameManager) {
		if !surface_exists(oGlobalManager.transitionSurfacePing) oGlobalManager.transitionSurfacePing = surface_create(1920,1080);
		if !surface_exists(oGlobalManager.transitionSurfacePong) transitionSurfacePong = surface_create(1920,1080);
		transitionChange = _change;
		transitionPercent = 0;
		
		if _change {
			surface_set_target(oGlobalManager.transitionSurfacePing);
			draw_sprite_ext(sDoomWall,0,0,0,1920/48,1080/40,0,c_white,1);
			surface_reset_target();
		} else {
			audio_play_sound(snRoundStart,1,false,0.25*oGlobalManager.sfxVol);
			var _surface = view_get_surface_id(0);
			_surface = _surface == -1 ? application_surface : _surface;
			if surface_exists(_surface) {
				surface_set_target(oGlobalManager.transitionSurfacePing);
				draw_surface(_surface,0,0);
				surface_reset_target();
			}
		}
	}
	
	if !global.title and !_change {
		GLOBAL.roundStart = false;
		GLOBAL.gameOver = false;
		GLOBAL.scores = array_create(4,0);
		GLOBAL.time = 0;
		GLOBAL.camZoom = 0;
		
		instance_destroy(oPlayerDeath);
		
		with(oGameManager) {
			stopTimer = false;
			panelXPercent = -0.5;
			recordPercent = 0;
			hexPercent = 0;
			textPercent = 0;
			timeLeft = 10;
			leave = false;
			gotScores = array_create(4,false);
			gameOverScreenAppear = false;
			desyncTime = 60;
		}
		
		with(oGlobalManager) {
			number = 0;	
			if GLOBAL.numPlayers == 1 {
				if !switchedToSinglePlayer {
					global.playerSprites = array_create(4,global.playerSprites[playerNum]);
					GLOBAL.names = array_create(4,GLOBAL.names[playerNum]);
					oCamera.follow = array_create(4,oCamera.follow[playerNum]);
					switchedToSinglePlayer = true;
				}
				playerNum = irandom(3);
				GLOBAL.playersConnected = array_create(4,false);
				GLOBAL.playersConnected[playerNum] = true;
			}
		}
		
		var _dir = irandom(360);
	
		with(oPlayer) {
			visible = true;
			dead = false;
			deadObject = noone;
			hSpd = 0;
			vSpd = 0;
			drawingLine = false;
			if GLOBAL.numPlayers == 1 index = oGlobalManager.playerNum;
			x = round(room_width/2+lengthdir_x(650,_dir-index*360/GLOBAL.numPlayers));
			y = round(room_height/2+lengthdir_y(650,_dir-index*360/GLOBAL.numPlayers));
		}
		
		if GLOBAL.numPlayers == 1 {
			if !instance_exists(oBot) instance_create_layer(room_width/2,room_height/2,"Players",oBot);
			with(oBot) {
				hSpd = 0;
				vSpd = 0;
				x = room_width/2;
				y = room_height/2;
				timer = 60;
				fast = 0;
			}
		} else instance_destroy(oBot);
		
		with(oCamera) {
			GLOBAL.spectateMode = array_create(4,false);	
			for(var i = 0; i < 4; i++) {
				if !instance_exists(follow[i]) continue;
				oGameManager.camPositionsX[i] = follow[i].x - camW/2;
				oGameManager.camPositionsY[i] = follow[i].y - camH/2;
			}
			camX = CamX;
			camY = CamY;
			spectatingWait = 10;
		}
		
		with(oDoomWall) {
			x = room_width/2;
			y = room_height/2;

			xTo = x;
			yTo = y;

			xstart = x;
			ystart = y;
			
			in = true;
			
			wallLen = startMaxLen;
			disappear = 0;
			
			rotation = 0;
			maxLen = startMaxLen;
			minLen = startMinLen;
			
			wallPercent = 1;
		}
		
		with(oProjectile) {
			if created instance_destroy();
			hSpd = 0;
			vSpd = 0;
			x = xstart;
			y = ystart;
		}
	} else if !_change and global.title {
		global.title = false;
		instance_create_layer(0,0,"Global",oCamera);
		var _dir = random(360);
		for(var i = 0; i < 4; i++) {
			if !GLOBAL.playersConnected[i] continue;
			instance_create_layer(round(room_width/2+lengthdir_x(650,_dir-i*360/GLOBAL.numPlayers)),round(room_height/2+lengthdir_y(650,_dir-i*360/GLOBAL.numPlayers)),"Players",oPlayer,{
				player_id: i,
				player_local: oGlobalManager.playerNum == i
			});
		}

		if GLOBAL.numPlayers == 1 {
			instance_create_layer(room_width/2,room_height/2,"Players",oBot);
		}
		instance_destroy(oTitle);
		instance_create_layer(0,0,"DoomWall",oDoomWall);
		audio_stop_sound(mMusic);
		audio_stop_sound(mMusicIntro);
		instance_activate_object(oWall);
		instance_activate_object(oProjectile);
		
		var _num = 0;
		with(oWall) {
			if bumperIndex == -1 bumperIndex = irandom(1);
			num = _num;
			_num++;
		}
			
		var _layer = layer_get_id("Background");
		layer_hspeed(_layer,0);
		layer_vspeed(_layer,0);
	}
}

function DefeatPlayer(_id,_destroy = false) {
	with(oPlayer) {
		if index == _id {
			if dead and _destroy instance_destroy();
			else if visible {
				deadObject = instance_create_layer(x,y,"Dead",oPlayerDeath);
				with deadObject {
					index = other.index;
					image_angle = other.image_angle;
				}
					
				var _num = 0;
				with(oPlayer) {
					if visible _num++
				}
					
				var _dir = random(360);
				for (var i = 0; i < 2; i++) {
					if i == 0 and _num == 2 and !instance_exists(oBot) {
						with(instance_create_layer(x,y,"Players",oBot)) {
							scale = 0;
							hSpd = lengthdir_x(13,_dir+120*i);
							vSpd = lengthdir_y(13,_dir+120*i);
						}
					} else {
						with(instance_create_layer(x,y,"Projectiles",oProjectile)) {
							created = true;
							noProjectileCollision = true;
							image_angle = other.image_angle;
							colour = global.colours[other.index];
							colourAmount = 1;
							hSpd = lengthdir_x(13,_dir+120*i);
							vSpd = lengthdir_y(13,_dir+120*i);
							image_xscale = 64/sprite_width;
							image_yscale = image_xscale;
							mass = 64/96;
						}
					}
				}
				visible = false;
					
				if _num <= 1 {
					oGameManager.stopTimer = true;
					audio_stop_sound(mMusic);
				}
			}
				
			break;
		}
	}
}