/// @desc Initialize Wall

wallPercent = 1; 
fullScreenSurface = surface_create(room_width,room_height);

startMaxLen = 2600;
startMinLen = 2200;

rotation = 0;
maxLen = startMaxLen;
maxLenMax = 700;
minLen = startMinLen;
minLenMax = 700;

wallLen = startMaxLen;
disappear = 0;

in = true;

curve = animcurve_get_channel(DoomCurve,0);

x = room_width/2;
y = room_height/2;

xTo = x;
yTo = y;

xstart = x;
ystart = y;

debug = false;

texWidth = sprite_get_width(sDoomWall);
texHeight = sprite_get_height(sDoomWall);

drawWall = function(_x,_y,_width,_height) {
	gpu_set_colorwriteenable(false,false,false,true);
	draw_rectangle(_x,_y,_x+_width,_y+_height,false);
	gpu_set_blendenable(false);
	draw_set_alpha(0);
	var _len = max(0,wallLen);

	for(var i = 0; i < 6; i++) {
		draw_triangle(x,y,x+lengthdir_x(_len,i*360/6+rotation),y+lengthdir_y(_len,i*360/6+rotation),x+lengthdir_x(_len,(i+1)*360/6+rotation),y+lengthdir_y(_len,(i+1)*360/6+rotation),false);
	}
	draw_set_alpha(1);
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	while _x < 0 _x += texWidth;
	while _y < 0 _y += texHeight;
	draw_sprite_ext(sDoomWall,0,_x-_x%texWidth,_y-_y%texHeight,_width/texWidth+1,_height/texHeight+1,0,c_white,1);
	gpu_set_blendmode(bm_normal);

	gpu_set_colorwriteenable(false,false,false,true);
	draw_rectangle(_x,_y,_x+_width,_y+_height,false);
	gpu_set_colorwriteenable(true,true,true,true);
	
	draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
	_width = 70+min(0,wallLen);
	_len += _width;
	for(var i = 0; i < 6; i++) {
		draw_line_width(
	
		x+lengthdir_x(_len,i*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
		y+lengthdir_y(_len,i*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
		x+lengthdir_x(_len,(i+1)*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
		y+lengthdir_y(_len,(i+1)*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
	
		_width);
	}
}

drawFullScreenSurface = function() {
	surface_set_target(fullScreenSurface);
	draw_sprite_ext(sDoomWall,0,0,0,room_width/288+1,room_height/240+1,0,c_white,1);
	draw_set_color(c_black);
	var _len = max(0,wallLen);
	
	gpu_set_blendmode(bm_subtract);
	for(var i = 0; i < 6; i++) {
		draw_triangle(x,y,x+lengthdir_x(_len,i*360/6),y+lengthdir_y(_len,i*360/6),x+lengthdir_x(_len,(i+1)*360/6),y+lengthdir_y(_len,(i+1)*360/6),false);
	}
	gpu_set_blendmode(bm_normal);
	
	draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
	var _width = 70+min(0,wallLen);
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
}

fullScreenSurface = surface_create(room_width,room_height);
drawFullScreenSurface();