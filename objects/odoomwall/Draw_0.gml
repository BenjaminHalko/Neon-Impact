/// @desc Draw Wall

if GLOBAL.roundStart {
	drawWall(CamXReal,CamYReal,surface,1920,1080);
	draw_surface(surface,CamXReal,CamYReal);
} else draw_surface(fullScreenSurface,0,0);