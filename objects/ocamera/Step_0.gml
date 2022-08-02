/// @desc Move Camera

//Spectate
if spectate {
	if instance_exists(global.spectate) {
		targetX = global.spectate.x-1920/2;
		targetY = global.spectate.y-1080/2;
	}
}
else if instance_exists(follow) { //Update target
	targetX = follow.x-1920/2;
	targetY = follow.y-1080/2;
}

//Move camera to target
camX += (targetX - camX) / 15;
camY += (targetY - camY) / 15;

//Shake
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

//Update Position
camera_set_view_pos(cam,camX+random_range(-shakeRemain,shakeRemain),camY+random_range(-shakeRemain,shakeRemain));