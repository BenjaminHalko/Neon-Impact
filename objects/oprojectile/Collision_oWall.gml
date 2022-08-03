/// @desc

if !SYNC exit;

Collision(other,1.1);
other.colour = image_blend;
other.colourAmount = 1;
other.scale = 1.3;

PlayAudio(snBumper,0.08,x,y);