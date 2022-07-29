/// @desc

if !visible or !global.roundStart exit;

Collision(other,1.5);
other.colour = global.colours[index];
other.colourAmount = 1;
other.scale = 1.3;

ScreenShake(10,25,x,y);