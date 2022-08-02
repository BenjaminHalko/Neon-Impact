/// @desc Title Logic

shift += 0.005;

if buttonPressed != -1 {
	buttonMovePercent = Approach(buttonMovePercent,1.1,0.02);	
	if global.multiplayer and buttonMovePercent > 0.5 and !drawTitleHexagons towerPercent = ApproachFade(towerPercent,1,0.02,0.9);
	
	for(var i = 0; i < 2; i++) {
		buttons[i].hovered = ApproachFade(buttons[i].hovered,buttonPressed == i,0.2,0.5);
		
		buttons[i].x = buttons[i].startX + 1250 * animcurve_channel_evaluate(curve,median(0,1,buttonMovePercent-0.1*(1-i)));
	}
	
} else {
	if !drawTitleHexagons buttonMovePercent = Approach(buttonMovePercent,0,0.02);	
	for(var i = 0; i < 2; i++) {
		buttons[i].x = buttons[i].startX + 1250 * animcurve_channel_evaluate(curve,median(0,1,buttonMovePercent-0.1*(1-i)));
		if point_in_rectangle(mouse_x,mouse_y,buttons[i].x,buttons[i].y,buttons[i].x+buttonWidth*buttons[i].scale+lengthdir_x(20,-120),buttons[i].y+buttonHeight*buttons[i].scale+lengthdir_y(20,-120)) {
			buttons[i].hovered = ApproachFade(buttons[i].hovered,1,0.2,0.8);
			if mouse_check_button_pressed(mb_left) {
				buttonPressed = i;
				global.multiplayer = i;
				instance_create_layer(0,0,layer,oGameManager);
			}
		} else buttons[i].hovered = ApproachFade(buttons[i].hovered,0,0.2,0.8);
	}
}

var _musicHovered = point_in_rectangle(mouse_x,mouse_y,volX-5,volY1-15,volX+volWidth+10,volY1+15);
var _sfxHovered = point_in_rectangle(mouse_x,mouse_y,volX-5,volY2-15,volX+volWidth+10,volY2+15);

musicAlpha = ApproachFade(musicAlpha,0.3+0.7*(_musicHovered or musicClicked),0.05,0.8);
sfxAlpha = ApproachFade(sfxAlpha,0.3+0.7*(_sfxHovered or sfxClicked),0.05,0.8);

if buttonMovePercent < 0.25 and buttonPressed == -1 {
	if mouse_check_button_pressed(mb_left) {
		if _musicHovered musicClicked = true;
		if _sfxHovered sfxClicked = true;
	} else if !mouse_check_button(mb_left) {
		if sfxClicked audio_play_sound(snPlayerBonk,1,false,0.20*oGlobalManager.sfxVol);
		musicClicked = false;
		sfxClicked = false;
	} else if(musicClicked) oGlobalManager.musicVol = round(median(0,1,(mouse_x-volX)/volWidth)/0.05)*0.05;
	else if(sfxClicked) oGlobalManager.sfxVol = round(median(0,2,(mouse_x-volX)/volWidth/0.5)/0.05)*0.05;
}

musicDraw = ApproachFade(musicDraw,oGlobalManager.musicVol,1,0.5);
sfxDraw = ApproachFade(sfxDraw,oGlobalManager.sfxVol,1,0.5);

if drawTitleHexagons {
	titleY = ApproachFade(titleY,room_height/2,70,0.9);
} else {
	titleX = ApproachFade(titleX,700-1800*(buttonPressed != -1),90,0.9);	
	titleY = ApproachFade(titleY,325,90,0.9)+(sin(current_time/800*pi/2)*5);
	titleScale = ApproachFade(titleScale,0.8,0.05,0.9);
}

if !audio_is_playing(music) music = audio_play_sound(mMusic,1,true,oGlobalManager.musicVol);

if instance_exists(oGameManager) {
	audio_sound_gain(music,oGlobalManager.musicVol*0.9*(1-max(0,oGameManager.transitionPercent)),0);
} else {
	audio_sound_gain(music,oGlobalManager.musicVol*0.9,0);
}

var _pos = audio_sound_get_track_position(music);
if lastPos % (60/130) > _pos % (60/130) {
	titleScale = 0.85;
	if (towerPercent != 0) towerScale[(_pos % (120/130)) > (60/130)] = 1.2;
}
lastPos = _pos;