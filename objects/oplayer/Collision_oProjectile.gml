/// @desc

if !visible or !global.roundStart exit;

Collision(other,1.4+0.5*(other.object_index == oBot));
if other.object_index != oBot {
	other.colour = global.colours[index];
	ScreenShake(other.mass*8,15,x,y);
} else ScreenShake(20,25,x,y);