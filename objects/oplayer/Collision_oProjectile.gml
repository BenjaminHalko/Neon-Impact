/// @desc

if !visible or !global.roundStart or !SYNC exit;

Collision(other,1.4+0.5*(other.object_index == oBot));
if other.object_index != oBot {
	other.colour = global.colours[index];
	ScreenShake(other.mass*8,15,x,y);
	PlayAudio(snProjectileBonk,0.13,x,y,random_range(0.6,0.8)/other.mass);
} else {
	ScreenShake(20,25,x,y);
	PlayAudio(snPlayerBonk,0.15,x,y);
}