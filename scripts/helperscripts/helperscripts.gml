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

function ScreenShake(_magnitude, _length,_x=-1,_y=-1) {
	with (oCamera) {
		if (_x == -1 or point_in_rectangle(_x,_y,camX,camY,camX+camW,camY+camH)) and _magnitude > shakeRemain {
			shakeLength = _length;
			shakeMagnitude = _magnitude;
			shakeRemain = _magnitude;
		}
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
	if !SYNC return;
	with(oGameManager) {
		if !surface_exists(transitionSurfacePing) transitionSurfacePing = surface_create(1920,1080);
		if !surface_exists(transitionSurfacePong) transitionSurfacePong = surface_create(1920,1080);
		transitionChange = _change;
		transitionPercent = 0;
		
		if _change {
			surface_set_target(transitionSurfacePing);
			draw_sprite_ext(sDoomWall,0,0,0,1920/48,1080/40,0,c_white,1);
			surface_reset_target();
		} else {
			var _surface = view_get_surface_id(0);
			surface_set_target(transitionSurfacePing);
			draw_surface(_surface == -1 ? application_surface : _surface,0,0);
			surface_reset_target();
		}
	}
	
	if room == rGame and !_change {
		global.roundStart = false;
		global.gameOver = false;
		global.scores = array_create(4,0);
		global.spectate = noone;
		global.time = 0;
		global.camZoom = 0;
		
		instance_destroy(oPlayerDeath);
		
		with(oGameManager) {
			stopTimer = false;
			panelXPercent = -0.5;
			recordPercent = 0;
			hexPercent = 0;
			textPercent = 0;
			timeLeft = 10;
			leave = false;
		}
		
		with(oGlobalManager) {
			number = 0;	
			if global.numPlayers == 1 {
				global.playerSprites = array_create(4,global.playerSprites[playerNum]);
				playerNum = irandom(3);
				global.playersConnected = array_create(4,false);
				global.playersConnected[playerNum] = true;
			}
		}
		
		var _dir = random(360);
	
		with(oPlayer) {
			visible = true;
			dead = false;
			deadObject = noone;
			hSpd = 0;
			vSpd = 0;
			drawingLine = false;
			x = round(room_width/2+lengthdir_x(1600,_dir));
			y = round(room_height/2+lengthdir_y(1600,_dir));
			_dir -= 360/global.numPlayers;
			if global.numPlayers == 1 index = oGlobalManager.playerNum;
		}
		
		with(oCamera) {
			spectate = false;	
			camX = follow.x - camW/2;
			camY = follow.y - camH/2;
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
			maxLen = 0;
			minLen = 0;
			
			wallPercent = 1;
		}
		
		with(oProjectile) {
			if created instance_destroy();	
		}
	} else if !_change and room != rGame {
		room_goto(rGame);	
	}
}