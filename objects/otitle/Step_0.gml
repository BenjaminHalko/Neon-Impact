/// @desc Title Logic

shift += 0.005;

if buttonPressed != -1 {
	buttonMovePercent = Approach(buttonMovePercent,1.1,0.02);	
	if global.multiplayer and buttonMovePercent > 0.5 and !drawTitleHexagons towerPercent = ApproachFade(towerPercent,1,0.02,0.9);
	
	for(var i = 0; i < 2; i++) {
		buttons[i].hovered = ApproachFade(buttons[i].hovered,buttonPressed == i,0.2,0.5);
		
		buttons[i].x = buttons[i].startX + 1250 * animcurve_channel_evaluate(curve,median(0,1,buttonMovePercent-0.1*(1-i)));
	}
	
} else {
	if !drawTitleHexagons buttonMovePercent = Approach(buttonMovePercent,0,0.02);	
	for(var i = 0; i < 2; i++) {
		buttons[i].x = buttons[i].startX + 1250 * animcurve_channel_evaluate(curve,median(0,1,buttonMovePercent-0.1*(1-i)));
		if point_in_rectangle(mouse_x,mouse_y,buttons[i].x,buttons[i].y,buttons[i].x+buttonWidth*buttons[i].scale+lengthdir_x(20,-120),buttons[i].y+buttonHeight*buttons[i].scale+lengthdir_y(20,-120)) {
			buttons[i].hovered = ApproachFade(buttons[i].hovered,1,0.2,0.8);
			if mouse_check_button_pressed(mb_left) {
				buttonPressed = i;
				global.multiplayer = i;
				instance_create_layer(0,0,layer,oGameManager);
			}
		} else buttons[i].hovered = ApproachFade(buttons[i].hovered,0,0.2,0.8);
	}
}


if drawTitleHexagons {
	titleY = ApproachFade(titleY,room_height/2,70,0.9);
} else {
	titleX = ApproachFade(titleX,700-1800*(buttonPressed != -1),90,0.9);	
	titleY = ApproachFade(titleY,325,90,0.9)+(sin(current_time/1500*pi/2)*5);
	titleScale = ApproachFade(titleScale,0.8,0.05,0.9);
}