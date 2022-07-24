/// @desc

//Update target
if instance_exists(follow) {
	targetX = follow.x-960;
	targetY = follow.y-540;
}

//Move camera to target
camX += (targetX - camX) / 15;
camY += (targetY - camY) / 15;

//Don't Move Out Of Bounds
camX = clamp(camX,0,room_width-1920);
camY = clamp(camY,0,room_width-1080);

//Update Position
camera_set_view_pos(cam,camX,camY);