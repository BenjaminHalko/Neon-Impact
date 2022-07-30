/// @desc Flash Score

if keyboard_check_pressed(vk_tab) or device_mouse_check_button_pressed(2,mb_left) {
	if oRender.disable {
		oRender.disable = false;
		application_surface_draw_enable(false);
		if !surface_exists(oRender.viewSurface) oRender.viewSurface = surface_create(1920,1080);
		view_set_surface_id(0,oRender.viewSurface);
	} else {
		oRender.disable = true;
		application_surface_draw_enable(true);
		view_set_surface_id(0,-1);
	}	
}

if room != rGame exit;

if global.scores[playerNum] != 0 and number < maxNum and alarm[0] <= 0 alarm[0] = 30;