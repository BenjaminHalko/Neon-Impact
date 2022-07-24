/// @desc

//Update target
if instance_exists(follow) {
	targetX = follow.x-camW/2;
	targetY = follow.y-camH/2;
}

//Move camera to target
camX += (targetX - camX) / 15;
camY += (targetY - camY) / 15;

//Don't Move Out Of Bounds
camX = clamp(camX,0,room_width-camW);
camY = clamp(camY,0,room_width-camH);

//Update Position
camera_set_view_pos(cam,camX,camY);