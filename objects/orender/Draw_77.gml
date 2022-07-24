/// @desc Render Bloom

enableLive;

//Create Non-Existant Surfaces
if !surface_exists(surfacePing) {
	surfacePing = surface_create(1920,1080);
	bloomTexture = surface_get_texture(surfacePing);
}
if !surface_exists(surfacePong) surfacePong = surface_create(1920,1080);
if !surface_exists(global.bloomSurface) global.bloomSurface = surface_create(room_width,room_height);


//Bloom Setup
var _offsetX = -CamX;
var _offsetY = -CamY;

surface_set_target(surfacePing);
draw_clear(c_black);
draw_surface(global.bloomSurface,_offsetX,_offsetY);
surface_reset_target();

surface_set_target(application_surface);
draw_surface(global.bloomSurface,_offsetX,_offsetY);
surface_reset_target();

surface_set_target(surfacePong);
draw_clear(c_black);
shader_set(shBlur);
shader_set_uniform_f(uTexelSize,1/1920,1/1080);
shader_set_uniform_f(uBlurVector,0,1);
draw_surface(surfacePing,0,0);
surface_reset_target();

surface_set_target(surfacePing);
draw_clear(c_black);
shader_set_uniform_f(uBlurVector,1,0);
draw_surface(surfacePong,0,0);
surface_reset_target();
shader_reset();

surface_set_target(global.bloomSurface);
draw_clear(c_black);
shader_set(shBloom);
shader_set_uniform_f(uIntensity,0.9);
shader_set_uniform_f(uDarken,0.55);
texture_set_stage(uBloomTexture,bloomTexture);

draw_surface(application_surface,0,0);

shader_reset();
surface_reset_target();

//GUI

