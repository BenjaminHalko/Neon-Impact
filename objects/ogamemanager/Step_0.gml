/// @desc

if restart and !rollback_game_running game_restart();

if !rollback_game_running and keyboard_check_pressed(vk_enter) rollback_start_game();