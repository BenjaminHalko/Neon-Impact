/// @desc Draw Wall

if GLOBAL.roundStart {
	if wallLen == -70 {
		draw_sprite_ext(sDoomWall,0,CamXReal-CamXReal%texWidth,CamYReal-CamYReal%texHeight,1920/texWidth+1,1080/texHeight+1,0,c_white,1);	
	} else {
		drawWall(CamXReal,CamYReal,1920,1080);
	}
} else draw_surface(fullScreenSurface,0,0);