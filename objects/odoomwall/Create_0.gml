/// @desc Initialize Wall

wallPercent = 1;
surface = surface_create(1920,1080);
fullScreenSurface = surface_create(room_width,room_height);

startMaxLen = room_width/2-100;
startMinLen = 2300;

rotation = 0;
maxLen = 0;
maxLenMax = 800;
minLen = 0;
minLenMax = 500;

wallSpd = 0;

wallSpdArray = [0.0014,0.001,0.0007,0.0005];

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

drawWall = function(_x,_y,_surface,_width,_height) {
	surface_set_target(_surface);
	if oRender.disable draw_clear(#080019);
	else draw_sprite_ext(sDoomWall,0,-_x%288,-_y%240,_width/288+1,_height/240+1,0,c_white,1);

	draw_set_color(c_black);
	var _len = max(0,wallLen);
	_x = x-_x;
	_y = y-_y;
	
	gpu_set_blendmode(bm_subtract);
	for(var i = 0; i < 6; i++) {
		draw_triangle(_x,_y,_x+lengthdir_x(_len,i*360/6+rotation),_y+lengthdir_y(_len,i*360/6+rotation),_x+lengthdir_x(_len,(i+1)*360/6+rotation),_y+lengthdir_y(_len,(i+1)*360/6+rotation),false);
	}
	gpu_set_blendmode(bm_normal);
	
	draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
	_width = 70+min(0,wallLen);
	_len += _width;
	for(var i = 0; i < 6; i++) {
		draw_line_width(
	
		_x+lengthdir_x(_len,i*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
		_y+lengthdir_y(_len,i*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
		_x+lengthdir_x(_len,(i+1)*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
		_y+lengthdir_y(_len,(i+1)*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
	
		_width);
	}
	surface_reset_target();	
}

drawWall(0,0,fullScreenSurface,room_width,room_height);