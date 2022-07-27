/// @desc Player Line

// Feather disable GM1013
// Feather disable GM1011
if (!player_local and !oCamera.spectate) or !drawingLine exit;
	
var _len = min(launchLenMax,launchDist)/launchLenMax*400;
draw_sprite_ext(sLine,0,x+lengthdir_x(56,launchDir),y+lengthdir_y(56,launchDir),_len/18,1,launchDir,global.colours[index],1);