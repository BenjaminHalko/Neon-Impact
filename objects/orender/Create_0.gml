/// @desc Initialize Bloom

//Create Surfaces
viewSurface = -1;
guiSurface = -1;
surfacePing = -1;
surfacePong = -1;

uBlurVector = shader_get_uniform(shBlur,"blur_vector");

disable = false;

//Disable Render if Using OperaGX mobile
if os_type == os_operagx {
	var _info = os_get_info();
	disable = _info[? "mobile"];
	ds_map_destroy(_info);
	
	if disable {
		gpu_set_tex_filter(false);
		exit;
	}
}

viewSurface = surface_create(1920,1080);
application_surface_draw_enable(false);
view_set_surface_id(0,viewSurface);