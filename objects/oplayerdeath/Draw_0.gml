/// @desc Draw Sprite

if mode {
	var _colFade = merge_color(global.colours[4],global.colours[index],abs(1 - fadePercent % 2));
	var _col = make_color_hsv(colour_get_hue(_colFade),0,20);
	
	draw_sprite_ext(sPlayerDeath,4,x,y,1,1,image_angle,merge_color(_colFade,_col,min(1,linePercent)), min(1,2-linePercent));
	draw_sprite_ext(sPlayerDeath,index,x,y,lerp(width,1,linePercent/2),lerp(width,1,linePercent/2),image_angle,merge_color(c_black,_colFade,min(1,linePercent)), min(1,2-linePercent));
} else {
	draw_sprite_ext(sPlayerDeath,4,x,y,1,1,image_angle,global.colours[(number % 2) ? index : 4], 1);
	draw_sprite_ext(sPlayerDeath,index,x,y,width,width,image_angle,c_black, 1);
}