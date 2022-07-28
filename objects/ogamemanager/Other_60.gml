/// @desc Hexagonify image

if async_load[? "status"] < 0 exit;

for(var i = 0; i < 4; i++) {
	if global.playerSprites[i][0] == async_load[? "id"] {
		global.playerSprites[i] = HexagonSprite(global.playerSprites[i][0]);
		break;
	}
}