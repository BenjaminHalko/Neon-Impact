/// @desc

sprite = noone;

surfacePing = surface_create(sprite_get_width(sprite),sprite_get_height(sprite));
surfacePong = surface_create(sprite_get_width(sprite),sprite_get_height(sprite));

surface_set_target(surfacePing);
draw_sprite(other.sprite,0,0,0);
surface_reset_target();

surface_set_target(surfacePong);
shader_set(shBlur);
shader_set_uniform_f(oRender.uBlurVector,0,1);
draw_surface(surfacePing,0,0);
surface_reset_target();

surface_set_target(surfacePing);
shader_set_uniform_f(oRender.uBlurVector,1,0);
draw_surface_ext(surfacePong,0,0,1,1,0,make_color_hsv(0,0,255*0.9),1);
shader_reset();

gpu_set_blendmode(bm_add);
draw_sprite_ext(other.sprite,0,0,0,1,1,0,make_color_hsv(0,0,255*0.55),1);
gpu_set_blendmode(bm_normal);
surface_reset_target();

surface_save(surfacePing,"coverart.png");

surface_free(surfacePing);
surface_free(surfacePong);