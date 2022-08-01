/// @desc

if !visible or !other.visible or !global.roundStart or !SYNC exit;

Collision(other,1.4);

ScreenShake(10,25,x,y);

PlayAudio(snPlayerBonk,0.15,x,y);