/// @desc Game Management

if restart and (!global.multiplayer or !rollback_game_running) game_restart();
if PAUSE and keyboard_check_pressed(vk_enter) rollback_start_game();

if !stopTimer {
	if global.multiplayer global.time = rollback_current_frame/60;
	else global.time += 1/60;
}

if !global.gameOver and (alarm[0] <= 0 or !instance_exists(global.spectate) or global.spectate.dead) and rollback_sync_on_frame() {
	var _playerCount = instance_number(oPlayer);
	if _playerCount == 0 global.gameOver = true;
	else {
		var _originalNumber = spectatorNumber;
		do {
			spectatorNumber = (spectatorNumber + 1) % _playerCount;
			global.spectate = instance_find(oPlayer,spectatorNumber);
			if spectatorNumber == _originalNumber and global.spectate.dead global.gameOver = true;
		} until (instance_exists(global.spectate) and !global.spectate.dead) or global.gameOver;
		
		alarm[0] = 60 * 10;
	}
}
