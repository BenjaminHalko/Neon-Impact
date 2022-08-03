
/// @desc Game Management

if PAUSE {
	if room == rTitle and oTitle.multiplayerStart rollback_start_game();
	exit;
}

// GamePlay Stuff
if room == rGame {
	if global.roundStart {
		if !stopTimer {
			if global.multiplayer global.time = max(0,(rollback_confirmed_frame-rollbackSubtrackFrame)/60);
			else global.time += 1/60;
		}
		
		//Camera Movement
		for(var i = 0; i < 4; i++) {
			with(oCamera) {
				//Spectate
				if spectate[i] {
					if instance_exists(global.spectate) {
						targetX[i] = global.spectate.x-1920/2;
						targetY[i] = global.spectate.y-1080/2;
					}
				}
				else if instance_exists(follow[i]) { //Update target
					targetX[i] = follow[i].x-1920/2;
					targetY[i] = follow[i].y-1080/2;
				}	
			}
			camPositionsX[i] += (oCamera.targetX[i] - camPositionsX[i]) / 15;
			camPositionsY[i] += (oCamera.targetY[i] - camPositionsY[i]) / 15;
		}
		
		oCamera.camX = camPositionsX[oGlobalManager.playerNum];
		oCamera.camY = camPositionsY[oGlobalManager.playerNum];

		if !global.gameOver and (alarm[0] <= 0 or !instance_exists(global.spectate) or global.spectate.dead) and SYNC {
			var _playerCount = instance_number(oPlayer);
			if _playerCount == 0 global.gameOver = true;
			else {
				var _found = ds_list_create();
				do {
					spectatorNumber = (spectatorNumber + 1) % _playerCount;
					
					global.spectate = instance_find(oPlayer,spectatorNumber);
					if ds_list_find_index(_found,spectatorNumber) != -1 and global.spectate.dead global.gameOver = true;
					ds_list_add(_found,spectatorNumber);
				} until (instance_exists(global.spectate) and !global.spectate.dead) or global.gameOver;
		
				ds_list_destroy(_found);
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
				if alone {
					recordPercent -= 0.8 * array_length(oGlobalManager.globalScores);
					global.numPlayers = 1;
				}
				
				global.spectate = noone;
			}
		}
		
		if global.numPlayers == 1 and oGlobalManager.number > 2 and mouse_check_button_pressed(mb_left) {
			leave = true;
			audio_sound_gain(mGameOver,0,0.8);
		}
		
		if !gameOverScreenAppear and oCamera.spectate[oGlobalManager.playerNum] {
			gameOverScreenAppear = true;
			with(oPlayer) {
				if !other.gotScores[index] {
					other.gameOverScreenAppear = false;
					break;
				}
			}
		}
		
		if leave or gameOverScreenAppear or (global.numPlayers == 1 and global.gameOver) {
			if !leave {
				audio_sound_gain(mGameOver,1,0);
				if !audio_is_playing(mGameOver) and panelXPercent > 0 audio_play_sound(mGameOver,1,true,oGlobalManager.musicVol*0.7);
				panelXPercent = Approach(panelXPercent,1,0.015);
				if panelXPercent == 1 {
					timeLeft = Approach(timeLeft,0,1/60);
					if timeLeft == 0 {
						leave = true;
						audio_sound_gain(mGameOver,0,0.8);
					}
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
	} else if SYNC {
		var _lastZoom = global.camZoom;
		if transitionPercent == 1 {
			global.camZoom = Approach(global.camZoom,1,0.0075);
			audio_stop_sound(mGameOver);
		}
		var _percent = animcurve_channel_evaluate(other.xRecordCurve,global.camZoom);
		with(oCamera) {
			camX = lerp((room_width-camWMax)/2,oGameManager.camPositionsX[oGlobalManager.playerNum],_percent);
			camY = lerp((room_height-camHMax)/2,oGameManager.camPositionsY[oGlobalManager.playerNum],_percent);
			camW = lerp(camWMax,1920,_percent);
			camH = lerp(camHMax,1080,_percent);
			camera_set_view_size(cam,camW,camH);
		}
		if global.camZoom == 1 and SYNC {
			global.roundStart = true;
			audio_play_sound(mMusic,1,true,oGlobalManager.musicVol,choose(51.692, 95.999, 155.076));
			if global.multiplayer rollbackSubtrackFrame = rollback_confirmed_frame;
			with(oDoomWall) {
				surface_resize(surface,1920,1080);
			}
		}
	}
} else if transitionPercent == 1 and (oTitle.buttonPressed == 1 or oTitle.buttonMovePercent >= 0.7) and SYNC {
	Transition(true);
	if oTitle.buttonPressed == 1 {
		oTitle.multiplayerStart = true;
		oTitle.startScaleBounce = 0.15;
		transitionPercent = -1.1;
	}
}

//Transition
if transitionPercent != 1 {
	if !surface_exists(oGlobalManager.transitionSurfacePong) oGlobalManager.transitionSurfacePong = surface_create(1920,1080);
	transitionPercent = Approach(transitionPercent,1,0.02);
	transitionDir -= 0.7;
	if transitionPercent == 1 {
		if transitionChange Transition();
		else {
			surface_free(oGlobalManager.transitionSurfacePing);
			surface_free(oGlobalManager.transitionSurfacePong);
		}
	}
}