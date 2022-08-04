/// @desc Draw Title + Buttons

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(GuiFont);

draw_sprite(sMultiplayer,0,buttons[1].x+buttonWidth/2,buttons[1].y-buttons[1].hovered*160+70);
draw_sprite_ext(sSingleplayer,0,buttons[0].x+270+270*buttons[0].hovered,buttons[0].y+60,1,1,15,c_white,1);

if buttonMovePercent != 1.1 {
	for(var i = 0; i < 2; i++) {
		draw_sprite_ext(sRanking,0,buttons[i].x+lengthdir_x(20+buttons[i].hovered*10,-150),buttons[i].y+lengthdir_y(20+buttons[i].hovered*10,-150),buttons[i].scale,buttons[i].scale,0,buttons[i].col,1);
		draw_sprite_ext(sRanking,0,buttons[i].x,buttons[i].y-buttons[i].hovered*15,buttons[i].scale,buttons[i].scale,0,make_color_hsv(colour_get_hue(buttons[i].col),255,30),1);
	}
}

if (towerPercent != 0) {
	towerScale[0] = ApproachFade(towerScale[0],1,0.05,0.8);
	towerScale[1] = ApproachFade(towerScale[1],1,0.05,0.8);
	var _y = 400*(1-towerPercent)+roomHeight+10;
	var _shake = 25;
	var _col = global.colours[1+multiplayerStart];
	draw_sprite_ext(sConnecting,0,400+random_range(-_shake,_shake)*(1-towerPercent),_y+random_range(-_shake,_shake)*(1-towerPercent),towerScale[0],towerScale[0],0,_col,1);
	draw_sprite_ext(sConnecting,0,roomWidth-400+random_range(-_shake,_shake)*(1-towerPercent),_y+random_range(-_shake,_shake)*(1-towerPercent),towerScale[1],towerScale[1],0,_col,1);
	
	draw_set_color(_col);
	if towerPercent >= 0.99 {
		for(var j = 0; j < 4; j++) {
			var _x = 400;
			if j % 2 _x = roomWidth - _x;
			_y = roomHeight-200*towerScale[j % 2];
			towerRings[j] += 7;
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
		draw_text_transformed(roomWidth/2,roomHeight/2-100+100*(towerScale[1]-1),"STARTING "+(GLOBAL.numPlayers == 1 ? "SINGLEPLAYER" : "MULTIPLAYER"),towerScale[0],towerScale[0],0);
	} else if (global.multiplayer) {
		draw_set_color(global.colours[1]);
		if !connected {
			draw_text_transformed(roomWidth/2,roomHeight/2-100+100*(towerScale[1]-1),"CONNECTING",towerScale[0],towerScale[0],0);
		} else {
			draw_text_transformed(roomWidth/2,roomHeight/2-20-100+100*(towerScale[1]-1),string(GLOBAL.numPlayers)+" OUT OF 4 PLAYERS JOINED",towerScale[0],towerScale[0],0);
			draw_text_transformed(roomWidth/2,roomHeight/2+20-100+100*(towerScale[1]-1),host ? "PRESS START WHEN READY" : "WAITING FOR HOST TO START",towerScale[0],towerScale[0],0);
			
		}
	}
	
	//Start
	if connected and host {
		draw_set_alpha(min(buttonMovePercent*7,1)*(buttonPressed == 1)-0.2*(1-startPercent));
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(roomWidth/2,startY,"START",max(0,max(towerScale[0],towerScale[1])*1.5+startPercent+startScale),max(0,max(towerScale[0],towerScale[1])*1.5+startPercent+startScale),0);
	}
	
	draw_set_alpha(1);

	gpu_set_tex_filter(_filter);
}

//Volume Control
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
var _pos;
draw_set_alpha(max(0,1-min(buttonMovePercent*7,1)*(buttonPressed != 1))*musicAlpha);
draw_set_color(global.colours[0]);
draw_line_width(volX,volY1,volX+volWidth,volY1,3);
_pos = volX + volWidth * musicDraw;
draw_rectangle(_pos-5,volY1-10,_pos+5,volY1+10,false);
draw_text(volX-20,volY1,"BGM");
draw_set_alpha(max(0,1-min(buttonMovePercent*7,1)*(buttonPressed != 1))*sfxAlpha);
draw_set_color(global.colours[2]);
draw_line_width(volX,volY2,volX+volWidth,volY2,3);
_pos = volX + volWidth * 0.5 * sfxDraw;
draw_rectangle(_pos-5,volY2-10,_pos+5,volY2+10,false);
draw_text(volX-20,volY2,"SFX");
draw_set_alpha(1);

//Title
shader_set(shTitleGradient);
shader_set_uniform_f(uDimensions,uvsW,uvsH);
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