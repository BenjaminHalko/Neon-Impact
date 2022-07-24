/// @desc

surface_set_target(surface);
draw_sprite_ext(sDoomWall,0,0,0,room_width/40,room_height/48,0,c_white,1);

draw_set_color(c_black);
var _len = room_width/2*wallPercent;
var _x = room_width/2;
var _y = room_height/2;

gpu_set_blendmode(bm_subtract);
for(var i = 0; i < 6; i++) {
	draw_triangle(_x,_y,_x+lengthdir_x(_len,i*360/6),_y+lengthdir_y(_len,i*360/6),_x+lengthdir_x(_len,(i+1)*360/6),_y+lengthdir_y(_len,(i+1)*360/6),false);
}
gpu_set_blendmode(bm_normal);
draw_set_color(global.colours[4]);
	var _width = 90;
	_len += _width;
for(var i = 0; i < 6; i++) {
	draw_line_width(
	
	_x+lengthdir_x(_len,i*360/6)-lengthdir_x(_width/2,(i-1)*360/6+90),
	_y+lengthdir_y(_len,i*360/6)-lengthdir_y(_width/2,(i-1)*360/6+90),
	_x+lengthdir_x(_len,(i+1)*360/6)-lengthdir_x(_width/2,(i-1)*360/6+90),
	_y+lengthdir_y(_len,(i+1)*360/6)-lengthdir_y(_width/2,(i-1)*360/6+90),
	
	_width);
}
surface_reset_target();

draw_surface(surface,0,0);