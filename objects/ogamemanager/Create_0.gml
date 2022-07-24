/// @desc

rollback_define_input({
	mouseLeft: mb_left,
	mouseX: m_axisx_gui,
	mouseY: m_axisy_gui
});

rollback_define_player(oPlayer);

if !rollback_join_game() {
	rollback_create_game(1,true);	
}

restart = false;
names = ["PLAYER 1","REALLY BIG NAME YEP YEP YEP", "NAME NOPE", "NAME YEP YEP YEP"];

create = false;