/// @desc Initialize Camera

cam = view_get_camera(0);
camW = camera_get_view_width(cam);
camH = camera_get_view_height(cam);
camX = 0;
camY = 0;

spectatingWait = 10;

targetX = array_create(4,0);
targetY = array_create(4,0);

follow = array_create(4,noone);
GLOBAL.spectateMode = array_create(4,false);

shakeRemain = 0;
shakeLength = 0;
shakeMagnitude = 0;

camWMax = room_width-500;
camHMax = camWMax/16*9;