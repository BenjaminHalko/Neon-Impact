/// @desc Create Players

if room != rGame exit;

var _dir = random(360);
for(var i = 0; i < 4; i++) {
	if !global.playersConnected[i] continue;
	instance_create_layer(round(room_width/2+lengthdir_x(800,_dir)),round(room_height/2+lengthdir_y(800,_dir)),"Players",oPlayer,{
		player_id: i,
		player_local: oGlobalManager.playerNum == i
	});
	_dir -= 360/max(2,global.numPlayers);
}

if global.numPlayers == 1 {
	instance_create_layer(round(room_width/2+lengthdir_x(800,_dir)),round(room_height/2+lengthdir_y(800,_dir)),"Players",oBot);
}