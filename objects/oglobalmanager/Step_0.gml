/// @desc Flash Score

if global.isBrowser ScaleCanvas();

if !global.isBrowser and os_type != os_operagx {
	if keyboard_check_pressed(vk_f4) or keyboard_check_pressed(vk_f11) window_set_fullscreen(!window_get_fullscreen());
	if keyboard_check_pressed(vk_escape) game_end();
	
	var _aspect = 1920/1080;
	windowW = window_get_width();
	windowH = window_get_height();
}

if global.mobile and keyboard_check_pressed(vk_backspace) game_end();

if keyboard_check_pressed(vk_shift) or device_mouse_check_button_pressed(3,mb_left) {
	if oRender.disable {
		if oRender.disable == 2 {
			application_surface_draw_enable(false);
			if !surface_exists(oRender.viewSurface) oRender.viewSurface = surface_create(1920,1080);
			view_set_surface_id(0,oRender.viewSurface);
			gpu_set_tex_filter(true);
		}
	} else {
		application_surface_draw_enable(true);
		// Feather disable once GM1029
		view_set_surface_id(0,-1);
		gpu_set_tex_filter(oRender.disable != 2);
	}

	oRender.disable++;
	if oRender.disable == 3 oRender.disable = 0;
	qualitySign = 60;
	
	ini_open(SAVEFILE);
	ini_write_real("graphics","disableFX",oRender.disable);
	ini_close();
}

if qualitySign != 0 qualitySign--;

if global.title exit;

if GLOBAL.scores[playerNum] != 0 and number < maxNum and alarm[0] <= 0 alarm[0] = 30;

if !ds_map_empty(audioPlaying) {
	for(var i = ds_map_find_first(audioPlaying); i != undefined; i = ds_map_find_next(audioPlaying,i)) {
		if !audio_is_playing(audioPlaying[? i]) ds_map_delete(audioPlaying,i);
	}
}

//Music
var _pos = audio_sound_get_track_position(music);
bumperScale[0] = ApproachFade(bumperScale[0],0,0.05,0.8);
bumperScale[1] = ApproachFade(bumperScale[1],0,0.05,0.8);
if musicLastPos % (60/130) > _pos % (60/130) bumperScale[(_pos % (120/130)) > (60/130)] = 0.35;
musicLastPos = _pos;