/// @desc

buttons = [{
	startX: 900,
	x: 900,
	y: 800,
	scale: 0.8,
	hovered: 0,
	text: "SINGLEPLAYER",
	col: global.colours[4],
	textScale: 1
},{
	startX: 1000,
	x: 1000,
	y: 600,
	scale: 1,
	hovered: 0,
	text: "MULTIPLAYER",
	col: global.colours[1],
	textScale: 1.3
}];

buttonWidth = sprite_get_width(sRanking);
buttonHeight = sprite_get_height(sRanking)+lengthdir_y(20,-30);

buttonPressed = -1;
buttonMovePercent = 0;

multiplayerStart = false;
connected = false;

towerPercent = 0;

towerRings = [0,-500,-100,-600];

curve = animcurve_get_channel(GameOverCurve,"xRecord");

if(gxc_get_query_param("roomUrl") != undefined) {
	buttonPressed = 1;
	global.multiplayer = true;
	instance_create_layer(0,0,layer,oGameManager);
	towerPercent += 0.01;
}