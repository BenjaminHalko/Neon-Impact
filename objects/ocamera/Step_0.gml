/// @desc Move Camera

// The rest of the camera code is in oGameManager because of rollback issues. :(

//Shake
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

//Update Position
camera_set_view_pos(cam,camX+random_range(-shakeRemain,shakeRemain),camY+random_range(-shakeRemain,shakeRemain));