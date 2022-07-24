/// @desc

enableLive;

wallPercent = Wave(0,1,40,0);
if !surface_exists(surface) surface = surface_create(room_width,room_height);

if rollback_sync_on_frame() {
var _len = room_width/2*wallPercent;
var _x = room_width/2;
var _y = room_height/2;
with (oPlayer) {
	var _dead = true;
	
	for(var i = 0; i < 6; i++) {
		if point_in_triangle(x,y,_x,_y,_x+lengthdir_x(_len-sprite_width/2,i*360/6),_y+lengthdir_y(_len-sprite_width/2,i*360/6),_x+lengthdir_x(_len-sprite_width/2,(i+1)*360/6),_y+lengthdir_y(_len-sprite_width/2,(i+1)*360/6)) {
			_dead = false;
			break;
		}
	}
	
	if _dead {
		instance_create_layer(x,y,"Dead",oPlayerTrail);	
	}
}
}