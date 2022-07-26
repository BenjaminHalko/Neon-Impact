/// @desc Player Line

// Feather disable once GM1013
// Feather disable once GM1011
if disable or (!player_local and (!oCamera.spectate or global.spectate != id)) or !drawingLine exit;
	
draw_sprite_ext(sLine,0,mouseClickX+CamX,mouseClickY+CamY,launchDist/18,0.5,180+launchDir,c_white,0.7);
var _len = min(launchLenMax,launchDist)/launchLenMax*400;
draw_sprite_ext(sLine,0,x+lengthdir_x(56,launchDir),y+lengthdir_y(56,launchDir),_len/18,1,launchDir,global.colours[index],1);