/// @desc

if !visible or !other.visible or !GLOBAL.roundStart or !SYNC exit;

if point_distance(0,0,hSpd,vSpd) < point_distance(0,0,other.hSpd,other.vSpd) exit;

Collision(other,1.4);

if player_local or ((GLOBAL.spectate == id or GLOBAL.spectate == other.id) and SPECTATING) or other.player_local ScreenShake(10,25,x,y);

PlayAudio(snPlayerBonk,0.20,x,y);