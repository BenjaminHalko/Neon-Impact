/// @desc Setup Player

index = 0;
/// feather disable GM1013
index = player_id;
// Feather disable once GM1011
oCamera.follow[index] = id;
oGameManager.camPositionsX[index] = x - 960;
oGameManager.camPositionsY[index] = y - 540;
/// feather enable GM1013

if global.multiplayer {
	var _info = rollback_get_info(index);
	if _info.player_type == "User" GLOBAL.names[index] = _info.player_name;
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
maxSpd = 40;

dead = false;
deadObject = noone;

mass = 1;
hSpd = 0;
vSpd = 0;

scale = 1;
scaleSpd = 0;

collisionWidth = round(bbox_right-bbox_left);