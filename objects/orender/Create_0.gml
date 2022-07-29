/// @desc Initialize Bloom

//Create Surfaces
viewSurface = -1;
guiSurface = -1;
surfacePing = -1;
surfacePong = -1;

//instance_deactivate_object(id);
//exit;

//Disable Render if Using OperaGX mobile
if os_type == os_operagx {
	var _info = os_get_info();
	var _disable = _info[? "mobile"];
	ds_map_destroy(_info);
	
	if _disable {
		instance_deactivate_object(id);
		exit;
	}
}

application_surface_draw_enable(false);

uBlurVector = shader_get_uniform(shBlur,"blur_vector");
uBloomTexture = shader_get_sampler_index(shBloom,"bloom_texture");

bloomTexture = undefined;

viewSurface = surface_create(1920,1080);

view_set_surface_id(0,viewSurface);