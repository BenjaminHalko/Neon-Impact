/// @desc Render Bloom

if disable exit;

surface_reset_target();

//Create Non-Existant Surfaces
if !surface_exists(surfacePing) {
	surfacePing = surface_create(global.resW,global.resH);
}
if !surface_exists(surfacePong) surfacePong = surface_create(global.resW,global.resH);
if !surface_exists(viewSurface) {
	viewSurface = surface_create(global.resW,global.resH);
	view_set_surface_id(0,viewSurface);
}

//Bloom
surface_set_target(surfacePing);
draw_surface(viewSurface,0,0);
draw_surface_ext(guiSurface,0,0,global.resW/1920,global.resH/1080,0,c_white,1);
surface_reset_target();

surface_set_target(surfacePong);
shader_set(shBlur);
shader_set_uniform_f(uTexelSize,1/global.resW,1/global.resH);
shader_set_uniform_f(uBlurVector,0,1);
draw_surface(surfacePing,0,0);
surface_reset_target();

shader_set_uniform_f(uBlurVector,1,0);
draw_surface_ext(surfacePong,0,0,1,1,0,make_color_hsv(0,0,255*0.9),1);
shader_reset();

gpu_set_blendmode(bm_add);
draw_surface_ext(viewSurface,0,0,1,1,0,make_color_hsv(0,0,255*0.55),1);
gpu_set_blendmode(bm_normal);

var _filter = gpu_get_tex_filter();
gpu_set_tex_filter(false);
draw_surface_ext(guiSurface,0,0,global.resW/1920,global.resH/1080,0,c_white,1);
gpu_set_tex_filter(_filter);

if global.title {
	with(oTitle) drawTitleOutline(global.resW/1920);
}