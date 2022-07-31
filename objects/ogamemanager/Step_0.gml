/// @desc Game Management

if PAUSE {
	if mouse_check_button_pressed(mb_left) rollback_start_game();
	exit;
}

// GamePlay Stuff
if room == rGame {
	if global.roundStart {
		if !stopTimer {
			if global.multiplayer global.time = max(0,(rollback_confirmed_frame-rollbackSubtrackFrame)/60);
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
				alone = true;
				var _grid = ds_grid_create(2,4);
				for (var i = 0; i < 4; i++) {
					ds_grid_add(_grid,0,i,i);
					ds_grid_add(_grid,1,i,global.scores[i]);
				}
				ds_grid_sort(_grid,1,false);
				for (var i = 0; i < 4; i++) {
					winOrder[i] = _grid[# 0,i];
					if global.scores[winOrder[i]] == 0 recordPercent += 0.8;
					else if i != 0 alone = false;
				}
				ds_grid_destroy(_grid);
				if alone recordPercent -= 0.8 * array_length(oGlobalManager.globalScores);
			}
		}

		if global.numPlayers == 1 and oGlobalManager.number > 2 and mouse_check_button_pressed(mb_left) leave = true;
		if global.gameOver or leave {
			if !leave {
				panelXPercent = Approach(panelXPercent,1,0.015);
				if panelXPercent == 1 {
					timeLeft = Approach(timeLeft,0,1/60);
					if timeLeft == 0 leave = true;
					recordPercent = Approach(recordPercent,2.6,0.03);
					if recordPercent >= 1.4 {
						hexPercent = Approach(hexPercent,2,0.03);
						if hexPercent == 2 {
							textPercent = Approach(textPercent,3,0.06);
						}
					}
				}
			} else {
				panelXPercent = Approach(panelXPercent,-0.5,0.04);
				if panelXPercent == -0.5 {
					transitionDir = random(360);
					Transition();
				}
			}
		}
	} else {
		var _lastZoom = global.camZoom;
		if !surface_exists(transitionSurfacePing) global.camZoom = Approach(global.camZoom,1,0.0075);
		var _percent = animcurve_channel_evaluate(other.xRecordCurve,global.camZoom);
		with(oCamera) {
			camX = lerp((room_width-camWMax)/2,targetX,_percent);
			camY = lerp((room_height-camHMax)/2,targetY,_percent);
			camW = lerp(camWMax,1920,_percent);
			camH = lerp(camHMax,1080,_percent);
			camera_set_view_size(cam,camW,camH);
		}
		if global.camZoom == 1 and SYNC {
			global.roundStart = true;
			if global.multiplayer rollbackSubtrackFrame = rollback_confirmed_frame;
			with(oDoomWall) {
				surface_resize(surface,1920,1080);
			}
		}
	}
} else if (!oTitle.multiplayerStart and global.multiplayer) or (wait != 0 and wait != 1) {
	oTitle.multiplayerStart = true;
	wait = Approach(wait,1,0.02);
} else if !surface_exists(transitionSurfacePing) and oTitle.buttonMovePercent >= 0.7 {
	Transition(true);
}

//Transition
if surface_exists(transitionSurfacePing) {
	if !surface_exists(transitionSurfacePong) transitionSurfacePong = surface_create(1920,1080);
	transitionPercent = Approach(transitionPercent,1,0.02);
	transitionDir -= 0.7;
	if transitionPercent == 1 and SYNC {
		if transitionChange Transition();
		else {
			surface_free(transitionSurfacePing);
			surface_free(transitionSurfacePong);
		}
	}
}