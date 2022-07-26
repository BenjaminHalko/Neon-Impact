/// @desc

//Spectate
if spectate {
	if instance_exists(global.spectate) {
		targetX = global.spectate.x-camW/2;
		targetY = global.spectate.y-camH/2;
	}
}
else if instance_exists(follow) { //Update target
	targetX = follow.x-camW/2;
	targetY = follow.y-camH/2;
}

//Move camera to target
camX += (targetX - camX) / 15;
camY += (targetY - camY) / 15;

//Don't Move Out Of Bounds
camX = clamp(camX,0,room_width-camW);
camY = clamp(camY,0,room_height-camH);

//Shake
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

//Update Position
camera_set_view_pos(cam,camX+random_range(-shakeRemain,shakeRemain),camY+random_range(-shakeRemain,shakeRemain));