/// @desc Setup Player

index = 0;
/// feather disable GM1013
index = player_id;
// Feather disable once GM1011
if player_local oCamera.follow = id;
/// feather enable GM1013

if global.multiplayer {
	if player_type == "User" {
		global.names[index] = "Benjamin";//player_name;
	}
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

dead = false;
deadObject = noone;

mass = 1;
hSpd = 0;
vSpd = 0;

collisionWidth = round(bbox_right-bbox_left);

x = room_width/2+500;
y = room_height/2;

x -= 100 * index;