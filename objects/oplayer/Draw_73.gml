/// @desc Player Line

// Feather disable GM1013
// Feather disable GM1011
if (!player_local and (global.spectate != id or !oCamera.spectate)) or !drawingLine or !global.roundStart exit;
	
var _len = min(launchLenMax,launchDist)/launchLenMax*15;
for(var i = 0; i < _len; i++) {
	draw_sprite_ext(sArrow,0,x+lengthdir_x(56+i*18,launchDir),y+lengthdir_y(56+i*18,launchDir),1,1,launchDir,global.colours[index],min(1,_len-i));
}