/// @desc

if !visible or !GLOBAL.roundStart exit;

Collision(other,1.1+0.3*(other.object_index == oBot));
if other.object_index != oBot {
	other.colour = global.colours[index];
	if player_local or (GLOBAL.spectate == id and SPECTATING) ScreenShake(other.mass*8,15,x,y);
	PlayAudio(snProjectileBonk,0.17,x,y,random_range(0.6,0.8)/other.mass);
} else {
	if player_local or (GLOBAL.spectate == id and SPECTATING) ScreenShake(20,25,x,y);
	PlayAudio(snPlayerBonk,0.20,x,y);
}