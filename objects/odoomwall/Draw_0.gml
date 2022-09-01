/// @desc Draw Wall

if GLOBAL.roundStart {
	if oRender.disable == 2 {
		if wallLen != -70 {
			draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
			var _width = 70+min(0,wallLen);
			var _len = max(0,wallLen) + _width;
			for(var i = 0; i < 6; i++) {
				draw_line_width(
	
				x+lengthdir_x(_len,i*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
				y+lengthdir_y(_len,i*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
				x+lengthdir_x(_len,(i+1)*360/6+rotation)-lengthdir_x(_width/2,(i-1)*360/6+90+rotation),
				y+lengthdir_y(_len,(i+1)*360/6+rotation)-lengthdir_y(_width/2,(i-1)*360/6+90+rotation),
	
				_width);
			}
		}
		var _xMinus = CamXReal;
		var _yMinus = CamYReal;
		while(_xMinus < 0) _xMinus += texWidth;
		while(_yMinus < 0) _yMinus += texHeight;
		draw_sprite_ext(sDoomWall,0,CamXReal-_xMinus%texWidth,CamYReal-_yMinus%texHeight,1920/texWidth+1,1080/texHeight+1,0,c_white,disappear/50);
	} else {
		if wallLen == -70 {
			var _xMinus = CamXReal;
			var _yMinus = CamYReal;
			while(_xMinus < 0) _xMinus += texWidth;
			while(_yMinus < 0) _yMinus += texHeight;
			draw_sprite_ext(sDoomWall,0,CamXReal-_xMinus%texWidth,CamYReal-_yMinus%texHeight,1920/texWidth+1,1080/texHeight+1,0,c_white,1);	
		} else {
			drawWall(CamXReal,CamYReal,1920,1080);
		}
	}
} else if oRender.disable != 2 and !global.mobile draw_surface(fullScreenSurface,0,0);