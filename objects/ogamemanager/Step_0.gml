/// @desc

if restart and !rollback_game_running game_restart();

if !rollback_game_running and keyboard_check_pressed(vk_enter) rollback_start_game();

global.time = rollback_current_frame/60;

if alarm[0] <= 0 or !instance_exists(global.spectate) or global.spectate.dead {
	do {
		spectatorNumber = (spectatorNumber + 1) % instance_number(oPlayer);
		global.spectate = instance_find(oPlayer,spectatorNumber);
	} until instance_exists(global.spectate) and !global.spectate.dead;
		
	alarm[0] = 60 * 15;
}