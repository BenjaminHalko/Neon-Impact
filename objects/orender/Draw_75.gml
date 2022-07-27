/// @desc Render Bloom

surface_reset_target();

//Create Non-Existant Surfaces
if !surface_exists(surfacePing) {
	surfacePing = surface_create(1920,1080);
	bloomTexture = surface_get_texture(surfacePing);
}
if !surface_exists(surfacePong) surfacePong = surface_create(1920,1080);

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

surface_set_target(surfacePing);
shader_set_uniform_f(uBlurVector,1,0);
draw_surface(surfacePong,0,0);
surface_reset_target();
shader_reset();

shader_set(shBloom);
texture_set_stage(uBloomTexture,bloomTexture);
draw_surface(viewSurface,0,0);
shader_reset();

draw_surface(guiSurface,0,0);