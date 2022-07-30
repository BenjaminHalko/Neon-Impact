/// @desc

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(GuiFont);

for(var i = 0; i < 2; i++) {
	draw_sprite_ext(sRanking,0,buttons[i].x+lengthdir_x(20+buttons[i].hovered*10,-150),buttons[i].y+lengthdir_y(20+buttons[i].hovered*10,-150),buttons[i].scale,buttons[i].scale,0,buttons[i].col,1);
	draw_sprite_ext(sRanking,0,buttons[i].x,buttons[i].y-buttons[i].hovered*15,buttons[i].scale,buttons[i].scale,0,make_color_hsv(colour_get_hue(buttons[i].col),255,30),1);
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
			/*
			if towerRings[j] >= 1000 or (multiplayerStart and towerRings[j] >= 300) towerRings[j] = 0;
			if multiplayerStart and abs(towerRings[j] - 180) < 10 towerRings[j] = 180;
			*/
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

var _filter = gpu_get_tex_filter();
gpu_set_tex_filter(false);
for(var i = 0; i < 2; i++) {
	draw_set_color(buttons[i].col);
	draw_text_transformed(buttons[i].x+buttonWidth*buttons[i].scale/2,buttons[i].y+buttonHeight*buttons[i].scale/2-buttons[i].hovered*15,buttons[i].text,buttons[i].textScale,buttons[i].textScale,0);	
}

draw_set_valign(fa_middle);
if multiplayerStart {
	draw_set_color(global.colours[2]);
	draw_text(room_width/2,room_height/2,"STARTING MULTIPLAYER");
} else if (global.multiplayer) {
	draw_set_color(global.colours[1]);
	if !connected {
		draw_text(room_width/2,room_height/2,"CONNECTING");
	} else {
		draw_text(room_width/2,room_height/2,"CLICK ANYWHERE TO START\n\n"+string(global.numPlayers)+" OUT OF 4 PLAYERS JOINED");
	}
}

gpu_set_tex_filter(_filter);