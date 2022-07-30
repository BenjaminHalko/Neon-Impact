/// @desc

if !visible or !global.roundStart exit;

Collision(other,1.4);
if other.object_index != oBot other.colour = global.colours[index];
else ScreenShake(10,25,x,y);