/// @desc Initialize Doom

index = 0;
number = 0;
mode = false;
flashSpd = 4;

linePercent = 0;
fadePercent = 0;

alarm[0] = flashSpd;

createProjectiles = true;

width = 96/sprite_get_width(sPlayerDeath);


ScreenShake(80,30,x,y);