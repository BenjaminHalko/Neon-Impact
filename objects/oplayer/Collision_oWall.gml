/// @desc

if !visible or !GLOBAL.roundStart or !SYNC exit;

Collision(other,1.4);
other.colour = global.colours[index];
other.colourAmount = 1;
other.scale = 1.8;

if player_local or (GLOBAL.spectate == id and SPECTATING) ScreenShake(10,25,x,y);
PlayAudio(snBumper,0.18,x,y);