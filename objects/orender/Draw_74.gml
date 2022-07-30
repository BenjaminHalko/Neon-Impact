/// @desc Setup Bloom

if disable exit;

if !surface_exists(guiSurface) guiSurface = surface_create(1920,1080);
// Feather disable once GM2046
surface_set_target(guiSurface);
draw_clear_alpha(c_black,0);