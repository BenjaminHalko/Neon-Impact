/// @desc Draw Self

draw_sprite_ext(sprite_index,index,x,y,1,scale,image_angle,image_blend,image_alpha);

if GLOBAL.numPlayers != 1 {
	var _filter = gpu_get_tex_filter();
	gpu_set_tex_filter(false);
	draw_set_color(global.colours[index]);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_alpha(0.75);
	draw_text_transformed(x,y-64,GLOBAL.names[index],0.6,0.6,0);
	draw_set_alpha(1);
	gpu_set_tex_filter(_filter);
}