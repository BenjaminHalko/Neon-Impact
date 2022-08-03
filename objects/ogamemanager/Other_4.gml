/// @desc Create Players

if room != rGame exit;

var _dir = random(360);
for(var i = 0; i < 4; i++) {
	if !global.playersConnected[i] continue;
	instance_create_layer(round(room_width/2+lengthdir_x(650,_dir-i*360/global.numPlayers)),round(room_height/2+lengthdir_y(650,_dir-i*360/global.numPlayers)),"Players",oPlayer,{
		player_id: i,
		player_local: oGlobalManager.playerNum == i
	});
}

if global.numPlayers == 1 {
	instance_create_layer(round(room_width/2+lengthdir_x(650,_dir-180)),round(room_height/2+lengthdir_y(650,_dir-180)),"Players",oBot);
}