/// @desc Draw Wall

enableLive;

surface_set_target(surface);
draw_sprite_ext(sDoomWall,0,0,0,room_width/48,room_height/40,0,c_white,1);

draw_set_color(c_black);
var _len = lerp(minLen,maxLen,animcurve_channel_evaluate(curve,wallPercent));

gpu_set_blendmode(bm_subtract);
for(var i = 0; i < 6; i++) {
	draw_triangle(x,y,x+lengthdir_x(_len,i*360/6+rotation),y+lengthdir_y(_len,i*360/6+rotation),x+lengthdir_x(_len,(i+1)*360/6+rotation),y+lengthdir_y(_len,(i+1)*360/6+rotation),false);
}
gpu_set_blendmode(bm_normal);
draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
	var _width = 70;
	_len += _width;
for(var i = 0; i < 6; i++) {
	draw_line_width(
	
	x+lengthdir_x(_len,i*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
	y+lengthdir_y(_len,i*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
	x+lengthdir_x(_len,(i+1)*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
	y+lengthdir_y(_len,(i+1)*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
	
	_width);
}
surface_reset_target();

draw_surface(surface,0,0);