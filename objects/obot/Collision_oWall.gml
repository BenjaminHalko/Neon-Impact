/// @desc

if !SYNC exit;

Collision(other,1.1);
other.colour = global.colours[4];
other.colourAmount = 1;
other.scale = 1.3;

PlayAudio(snBumper,0.12,x,y);