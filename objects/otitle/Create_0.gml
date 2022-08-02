/// @desc Initialize Title

buttons = [{
	startX: 1100,
	x: 0,
	y: 880,
	scale: 0.8,
	hovered: 0,
	text: "SINGLEPLAYER",
	col: global.colours[4],
	textScale: 1
},{
	startX: 1200,
	x: 0,
	y: 680,
	scale: 1,
	hovered: 0,
	text: "MULTIPLAYER",
	col: global.colours[1],
	textScale: 1.3
}];

buttonWidth = sprite_get_width(sRanking);
buttonHeight = sprite_get_height(sRanking)+lengthdir_y(20,-30);

buttonPressed = -1;
buttonMovePercent = 1.1;

multiplayerStart = false;
connected = false;

towerPercent = 0;

towerScale = [1,1];

towerRings = [0,-500,-100,-600];	

curve = animcurve_get_channel(GameOverCurve,"xRecord");

//Volume Control
volX = 400;
volWidth = 400;
volY1 = 800;
volY2 = 900;

musicAlpha = 0.5;
sfxAlpha = 0.5;

musicClicked = false;
sfxClicked = false;

musicDraw = 1;
sfxDraw = 1;

//Title Shader
var _uvs = sprite_get_uvs(sTitle,0);
uvsW = _uvs[2] - _uvs[0];
uvsH = _uvs[3] - _uvs[1];

uDimensions = shader_get_uniform(shTitleGradient,"uvDimensions");
uShift = shader_get_uniform(shTitleGradient,"shift");
shift = 0;

titleX = room_width/2;
titleY = room_height + 2500;
titleScale = 1;

titleHexagons = [];
hexagonScale = 0.8;
drawTitleHexagons = true;
var _hexagonSize = hexagonScale*sprite_get_width(sDefaultIcons);
var _width = _hexagonSize - lengthdir_x(_hexagonSize/2,-60) - 0.5;
var _height = lengthdir_x(_hexagonSize,-30) - 0.8;

var _below;
var _num = 0;
for(var j = -(room_height % _height)-8; j < room_height; j += _height) {
	_below = true;
	_num++;
	for(var i = -(room_width % _width)/2-lengthdir_x(_hexagonSize/2,-30); i < room_width; i += _width) {
		array_push(titleHexagons,{
			x: i,
			y: j + (lengthdir_x(_hexagonSize/2,-30)) * _below,
			offset: 3+0.0005*(point_distance(room_width/2,room_height/2,i+_hexagonSize/2,j + (lengthdir_x(_hexagonSize/2,-30) - 2) * _below+_hexagonSize/2))
		});
		_below = !_below;
	}
}

drawTitleOutline = function() {
	draw_sprite_ext(sTitle,1,titleX,titleY,titleScale,titleScale,0,c_white,1);
}

if(gxc_get_query_param("roomUrl") != undefined) {
	buttonPressed = 1;
	global.multiplayer = true;
	instance_create_layer(0,0,layer,oGameManager);
	towerPercent += 0.01;
}

music = audio_play_sound(mMusicIntro,1,false,0.9*oGlobalManager.musicVol);
lastPos = 0;