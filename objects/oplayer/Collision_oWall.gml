/// @desc

if !visible or !global.roundStart or !SYNC exit;

Collision(other,1.5);
other.colour = global.colours[index];
other.colourAmount = 1;
other.scale = 1.3;

if player_local or (global.spectate == id and SPECTATING) ScreenShake(10,25,x,y);
PlayAudio(snBumper,0.18,x,y);