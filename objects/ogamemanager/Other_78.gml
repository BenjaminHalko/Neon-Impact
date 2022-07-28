/// @desc Get User URL

if (rollback_event_id == rollback_chat_message) {
	var _url = rollback_event_param.message;
	var _num = rollback_event_param.from;
	global.playerSprites[_num][0] = sprite_add(_url,0,false,false,0,0);
}