/// @desc

if !visible or !other.visible or !global.roundStart exit;

Collision(other,1.4);

if player_local or ((global.spectate == id or global.spectate == other.id) and oCamera.spectate) or other.player_local ScreenShake(10,25,x,y);

PlayAudio(snPlayerBonk,0.20,x,y);