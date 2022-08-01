/// @desc

if !visible or !global.roundStart or !SYNC exit;

Collision(other,1.5);
other.colour = global.colours[index];
other.colourAmount = 1;
other.scale = 1.3;

ScreenShake(10,25,x,y);
PlayAudio(snBumper,0.12,x,y);