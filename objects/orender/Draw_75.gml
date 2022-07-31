/// @desc Render Bloom

if disable exit;

surface_reset_target();

//Create Non-Existant Surfaces
if !surface_exists(surfacePing) {
	surfacePing = surface_create(1920,1080);
}
if !surface_exists(surfacePong) surfacePong = surface_create(1920,1080);
if !surface_exists(viewSurface) viewSurface = surface_create(1920,1080);

//Bloom
surface_set_target(surfacePing);
draw_surface(viewSurface,0,0);
draw_surface(guiSurface,0,0);
surface_reset_target();

surface_set_target(surfacePong);
shader_set(shBlur);
shader_set_uniform_f(uBlurVector,0,1);
draw_surface(surfacePing,0,0);
surface_reset_target();

shader_set_uniform_f(uBlurVector,1,0);
draw_surface_ext(surfacePong,0,0,1,1,0,make_color_hsv(0,0,255*0.9),1);
shader_reset();

gpu_set_blendmode(bm_add);
draw_surface_ext(viewSurface,0,0,1,1,0,make_color_hsv(0,0,255*0.55),1);
gpu_set_blendmode(bm_normal);

draw_surface(guiSurface,0,0);

if room == rTitle {
	with(oTitle) drawTitleOutline();
}