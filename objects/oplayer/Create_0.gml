/// @desc Setup Player

index = 0;
/// feather disable GM1013
index = player_id;
// Feather disable once GM1011
if player_local oCamera.follow = id;
/// feather enable GM1013

var _info = rollback_get_info(index);
show_debug_message(_info.player_name)
if _info.player_type == "User" {
	
	oGameManager.names[index] = string_upper(_info.player_name);
}

image_angle = irandom(360);

mouseClickX = 0;
mouseClickY = 0;
mouseX = 0;
mouseY = 0;
drawingLine = false;
launchDir = image_angle;
launchDist = 0;
launchLenMax = 300;
launchSpd = 30;
maxSpd = 50;

mass = 1;
hSpd = 0;
vSpd = 0;

x = room_width/2;
y = room_height/2;

x -= 100 * index;