/// @desc Draw Title + Buttons

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(GuiFont);

if buttonMovePercent != 1.1 {
	for(var i = 0; i < 2; i++) {
		draw_sprite_ext(sRanking,0,buttons[i].x+lengthdir_x(20+buttons[i].hovered*10,-150),buttons[i].y+lengthdir_y(20+buttons[i].hovered*10,-150),buttons[i].scale,buttons[i].scale,0,buttons[i].col,1);
		draw_sprite_ext(sRanking,0,buttons[i].x,buttons[i].y-buttons[i].hovered*15,buttons[i].scale,buttons[i].scale,0,make_color_hsv(colour_get_hue(buttons[i].col),255,30),1);
	}
}

if (towerPercent != 0) {
	var _y = 300*(1-towerPercent)+room_height+10;
	var _shake = 15;
	var _col = global.colours[1+multiplayerStart];
	draw_sprite_ext(sConnecting,0,400+random_range(-_shake,_shake)*(1-towerPercent),_y+random_range(-_shake,_shake)*(1-towerPercent),1,1,0,_col,1);
	draw_sprite_ext(sConnecting,0,room_width-400+random_range(-_shake,_shake)*(1-towerPercent),_y+random_range(-_shake,_shake)*(1-towerPercent),1,1,0,_col,1);
	
	draw_set_color(_col);
	if towerPercent >= 0.99 {
		for(var j = 0; j < 4; j++) {
			var _x = 400;
			if j % 2 _x = room_width - _x;
			_y = room_height-200;
			towerRings[j] += 5;
			if towerRings[j] >= 1000 and !multiplayerStart towerRings[j] = 0;
			var _len =	towerRings[j];
			var _width = max(min(0,15-_len/10)+10,0);
			_len = max(0,_len);
			for(var i = 0; i < 5; i++) {
				draw_line_width(
	
				_x+lengthdir_x(_len,i*360/6-60)-lengthdir_x(_width/2,(i-1)*360/6+30),
				_y+lengthdir_y(_len,i*360/6-60)-lengthdir_y(_width/2,(i-1)*360/6+30),
				_x+lengthdir_x(_len,(i+1)*360/6-60)-lengthdir_x(_width/2,(i-1)*360/6+30),
				_y+lengthdir_y(_len,(i+1)*360/6-60)-lengthdir_y(_width/2,(i-1)*360/6+30),
	
				_width);
			}
		}
	}
}

if (buttonMovePercent != 1.1 or multiplayerStart or global.multiplayer) and !drawTitleHexagons {
	var _filter = gpu_get_tex_filter();
	gpu_set_tex_filter(false);
	for(var i = 0; i < 2; i++) {
		draw_set_color(buttons[i].col);
		draw_text_transformed(buttons[i].x+buttonWidth*buttons[i].scale/2,buttons[i].y+buttonHeight*buttons[i].scale/2-buttons[i].hovered*15,buttons[i].text,buttons[i].textScale,buttons[i].textScale,0);	
	}

	draw_set_valign(fa_middle);
	draw_set_alpha(min(buttonMovePercent*7,1))
	if multiplayerStart {
		draw_set_color(global.colours[2]);
		draw_text(room_width/2,room_height/2,"STARTING MULTIPLAYER");
	} else if (global.multiplayer) {
		draw_set_color(global.colours[1]);
		if !connected {
			draw_text(room_width/2,room_height/2,"CONNECTING");
		} else {
			draw_text(room_width/2,room_height/2-20,string(global.numPlayers)+" OUT OF 4 PLAYERS JOINED");
			draw_text(room_width/2,room_height/2+20,"CLICK ANYWHERE TO START");
			
		}
	}
	draw_set_alpha(1);

	gpu_set_tex_filter(_filter);
}

//Title
shader_set(shTitleGradient);
shader_set_uniform_f(uDimensions,uvsW*titleScale,uvsH*titleScale);
shader_set_uniform_f(uShift,shift % 1);
draw_sprite_ext(sTitle,0,titleX,titleY,titleScale,titleScale,0,c_white,1);
shader_reset();

//Start Surface
if drawTitleHexagons {
	drawTitleHexagons = false;
	for(var i = 0; i < array_length(titleHexagons); i++) {
		titleHexagons[i].offset = ApproachFade(titleHexagons[i].offset,0,0.06,0.75);
		var _alpha = min(titleHexagons[i].offset,1);
		if titleHexagons[i].offset != 0 drawTitleHexagons = true;
		if _alpha != 0 draw_sprite_ext(sDefaultIcons,4,titleHexagons[i].x,titleHexagons[i].y,hexagonScale,hexagonScale,0,merge_color(global.colours[4],c_black,median(0,1,_alpha*1.5-0.5)),_alpha);
	}
}

if oRender.disable drawTitleOutline();