/// @desc

disable = false;

if os_type == os_operagx {
	var _info = os_get_info();
	if _info[? "mobile"] disable = true;
	ds_map_destroy(_info);
	if disable {
		gpu_set_tex_filter(false);
		exit;
	}
}

application_surface_draw_enable(false);

uTexelSize = shader_get_uniform(shBlur,"texel_size");
uBlurVector = shader_get_uniform(shBlur,"blur_vector");

uIntensity = shader_get_uniform(shBloom,"bloom_intensity");
uDarken = shader_get_uniform(shBloom,"bloom_darken");
uBloomTexture = shader_get_sampler_index(shBloom,"bloom_texture");

global.bloomSurface = surface_create(1920,1080);
global.guiSurface = surface_create(1920,1080);
surfacePing = -1;
surfacePong = -1;
bloomTexture = undefined;

view_set_surface_id(0,global.bloomSurface);