/// @desc Start Game

oGlobalManager.playerNum = rollback_event_param.player_id;

if instance_number(oPlayer) == 1 {
	global.multiplayer = false;
	rollback_leave_game();
}