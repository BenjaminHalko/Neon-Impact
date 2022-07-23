/// @desc

draw_self();

if drawingLine {
	draw_sprite_ext(sLine,0,mouseClickX,mouseClickY,launchDist/18,0.5,180+launchDir,c_white,0.7);
	
	var _len = min(launchLenMax,launchDist)/launchLenMax*300;
	draw_sprite_ext(sLine,0,x+lengthdir_x(56,launchDir),y+lengthdir_y(56,launchDir),_len/18,1,launchDir,colours[image_index],1);
}