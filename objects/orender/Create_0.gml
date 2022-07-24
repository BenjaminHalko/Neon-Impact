/// @desc

application_surface_draw_enable(false);

uTexelSize = shader_get_uniform(shBlur,"texel_size");
uBlurVector = shader_get_uniform(shBlur,"blur_vector");

uIntensity = shader_get_uniform(shBloom,"bloom_intensity");
uDarken = shader_get_uniform(shBloom,"bloom_darken");
uBloomTexture = shader_get_sampler_index(shBloom,"bloom_texture");

global.bloomSurface = -1;
global.guiSurface = surface_create(1920,1080);
surfacePing = -1;
surfacePong = -1;
bloomTexture = undefined;

// Feather disable GM1044
layer_script_end(layer_get_id("Render"),function() {
	if event_type == ev_draw and event_number == 0 {
		if !surface_exists(global.bloomSurface) global.bloomSurface = surface_create(room_width,room_height);
		
		// Feather disable once GM2046
		surface_set_target(global.bloomSurface);
		draw_clear_alpha(c_black,0);
	}
});

layer_script_begin(layer_get_id("Render"),function() {
	if event_type == ev_draw and event_number == 0 surface_reset_target();
});