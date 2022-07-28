/// @desc Game Management

enableLive;

if restart and (!global.multiplayer or !rollback_game_running) game_restart();
if PAUSE and keyboard_check_pressed(vk_enter) rollback_start_game();

if PAUSE exit;

if !stopTimer {
	if global.multiplayer global.time = rollback_current_frame/60;
	else global.time += 1/60;
}

if !global.gameOver and (alarm[0] <= 0 or !instance_exists(global.spectate) or global.spectate.dead) and (!global.multiplayer or rollback_sync_on_frame()) {
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
	
	if global.gameOver {
		var _grid = ds_grid_create(2,4);
		for (var i = 0; i < 4; i++) {
			ds_grid_add(_grid,0,i,i);
			ds_grid_add(_grid,1,i,global.scores[i]);
		}
		ds_grid_sort(_grid,1,false);
		for (var i = 0; i < 4; i++) {
			winOrder[i] = _grid[# 0,i];
			if global.scores[winOrder[i]] == 0 recordPercent += 0.8;
		}
		ds_grid_destroy(_grid);
	}
}

if global.gameOver {
	if !leave {
		panelXPercent = Approach(panelXPercent,1,0.015);
		if panelXPercent == 1 {
			recordPercent = Approach(recordPercent,2.6,0.03);
			if recordPercent >= 1.4 {
				hexPercent = Approach(hexPercent,2,0.03);
				if hexPercent == 2 {
					textPercent = Approach(textPercent,3,0.06);
				}
			}
		}
	} else {
		panelXPercent = Approach(panelXPercent,0,0.04);
	}
}

if keyboard_check_pressed(vk_shift) leave = true;