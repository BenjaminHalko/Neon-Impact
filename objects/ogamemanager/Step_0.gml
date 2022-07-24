/// @desc

if restart and !rollback_game_running game_restart();

if !rollback_game_running and keyboard_check_pressed(vk_enter) rollback_start_game();

if create and rollback_sync_on_frame() {
	instance_create_layer(mouse_x+CamX,mouse_y+CamY,layer,oPlayerDeath);
	create = false;
}