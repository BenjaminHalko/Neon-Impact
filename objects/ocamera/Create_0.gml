/// @desc Initialize Camera

cam = view_get_camera(0);
camW = camera_get_view_width(cam);
camH = camera_get_view_height(cam);
camX = 0;
camY = 0;

targetX = 0;
targetY = 0;

follow = noone;
spectate = false;

shakeRemain = 0;
shakeLength = 0;
shakeMagnitude = 0;

camWMax = room_width-500;
camHMax = camWMax/16*9;