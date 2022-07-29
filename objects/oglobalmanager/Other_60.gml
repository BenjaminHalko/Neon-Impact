/// @desc Hexagonify Image

if async_load[? "status"] < 0 exit;

for(var i = 0; i < array_length(globalScores); i++) {
	if globalScores[i].sprite == async_load[? "id"] {
		globalScores[i].sprite = HexagonSprite(globalScores[i].sprite);
		break;
	}
}