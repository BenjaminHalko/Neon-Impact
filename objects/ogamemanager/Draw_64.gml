/// @desc Draw Time + Other On Screen Things

enableLive;

if !global.gameOver {
	var _camW = oCamera.camW;
	var _camH = oCamera.camH;

	var _alpha;
	with(oPlayer) {
		if (dead or point_in_rectangle(x,y,CamX-sprite_width/2,CamY-sprite_width/2,CamX+_camW+sprite_width/2,CamY+_camH+sprite_width/2)) continue;

		_alpha = 0.9;
		if instance_exists(deadObject) {
			if deadObject.mode draw_set_colour(merge_color(global.colours[4],global.colours[index],abs(1 - deadObject.fadePercent % 2)));
			else draw_set_colour(global.colours[(deadObject.number % 2) ? index : 4]);
			_alpha *= min(1,2 - deadObject.linePercent);
		} else if deadObject != noone _alpha = 0;
		else draw_set_colour(global.colours[index]);
	
		var _len = 0;
		var _dir = point_direction(960,540,x-CamX,y-CamY);
	
		if _dir > other.tanAngle and _dir <= 180-other.tanAngle _len = 500/dcos(_dir-90);
		else if _dir > 180-other.tanAngle and _dir <= 180+other.tanAngle _len = 920/dcos(_dir-180);
		else if _dir > 180+other.tanAngle and _dir <= 360-other.tanAngle _len = -500/dcos(_dir-90);
		else _len = -920/dcos(_dir-180);
	
		var _x = 960+lengthdir_x(_len,_dir);
		var _y = 540+lengthdir_y(_len,_dir);
		_len = 50;
		var _deg = 25;
		_dir = point_direction(960,540,_x,_y);
	
		draw_set_alpha(_alpha);
		draw_triangle(_x,_y,
		_x+lengthdir_x(_len,_dir-180-_deg),
		_y+lengthdir_y(_len,_dir-180-_deg),
		_x+lengthdir_x(_len,_dir-180+_deg),
		_y+lengthdir_y(_len,_dir-180+_deg),
	
		false);
	}
	draw_set_alpha(1);

	// Some Lovely Text
	draw_set_font(GuiFont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);

	if oCamera.spectate {
		draw_set_valign(fa_bottom);
		draw_set_alpha(Wave(0.5,0.7,4,0));
		draw_text(960,1060,"SPECTATING");
		draw_set_alpha(1);
		draw_set_valign(fa_top);
	}

	var _time = global.time;

	if global.scores[oGlobalManager.playerNum] != 0 and oGlobalManager.number != oGlobalManager.maxNum {
		_time = global.scores[oGlobalManager.playerNum];
		if oGlobalManager.number % 2 exit;
	}

	draw_text(960,20,string(_time div 60)+":"+string_replace(string_format(_time % 60,2,2)," ","0"));
} else {
	var _x, _y, _scale, _percent, _sprite, _player, _width, _textScale, _hexX, _panelX;
	
	if instance_exists(oRender) {
		surface_reset_target();
		surface_set_target(oRender.viewSurface);
	}
	
	//Panels
	draw_set_alpha(0.4);
	draw_set_color(global.colours[4]);
	_panelX = 1150*animcurve_channel_evaluate(xMoveCurve,panelXPercent);
	draw_triangle(_panelX,-1,_panelX-600,-1,_panelX-600,1080,false);
	draw_rectangle(0,0,_panelX-600,1080,false);
	draw_set_alpha(1);
	
	_hexX = lerp(2250,1500,animcurve_channel_evaluate(xMoveCurve,min(hexPercent,1))*animcurve_channel_evaluate(xMoveCurve,panelXPercent));
	_y = 150 * animcurve_channel_evaluate(hexYCurve,max(hexPercent-1,0));
	draw_primitive_begin(pr_trianglelist);
	for(var i = 0; i < 6; i++) {
		draw_vertex(_hexX,540);
		draw_vertex(_hexX+lengthdir_x(320,30+60*i),540+lengthdir_y(320,30+60*i)+_y*(1-(i <= 2)*2));
		draw_vertex(_hexX+lengthdir_x(320,90+60*i),540+lengthdir_y(320,90+60*i)+_y*(1-((i+1) % 6 <= 2)*2));
	}
	draw_primitive_end();
	
	draw_set_color(c_black)
	draw_primitive_begin(pr_trianglelist);
	for(var i = 0; i < 6; i++) {
		draw_vertex(_hexX,540);
		draw_vertex(_hexX+lengthdir_x(300,30+60*i),540+lengthdir_y(300,30+60*i)+_y*(1-(i <= 2)*2));
		draw_vertex(_hexX+lengthdir_x(300,90+60*i),540+lengthdir_y(300,90+60*i)+_y*(1-((i+1) % 6 <= 2)*2));
	}
	draw_primitive_end();
	
	if !sprite_exists(global.playerSprites[winOrder[0]][0])
			draw_sprite_ext(sDefaultIcons,winOrder[0],_hexX+defaultIconSize/2,700-defaultIconSize/2,1,1,-90,c_white,animcurve_channel_evaluate(xMoveCurve,median(textPercent-2,1,0)));

	// Not 1st Records
	for(var i = 0; i < 3; i++) {
		_player = winOrder[i+1];
		if global.scores[_player] == 0 continue;
		_percent = animcurve_channel_evaluate(xRecordCurve,min(1,recordPercent-0.8*(2-i)))
		_scale = 1 - (i != 0) * 0.15 - (i == 2) * 0.1;
		_x = _panelX - 1200 + 250 - 50 * i - 100 / _scale * (1 - _percent);
		_y = 280+200*i+30*(i != 0);
		
		draw_sprite_ext(sRanking,0,_x+lengthdir_x(20,-30),_y+lengthdir_y(20,-30),_scale,_scale,0,global.colours[_player],_percent);
		draw_sprite_ext(sRanking,0,_x,_y,_scale,_scale,0,c_black,_percent);
		
		if !sprite_exists(global.playerSprites[_player][0])
			draw_sprite_ext(sDefaultIcons,_player,_x+25*_scale,_y+15*_scale,100/defaultIconSize*_scale,100/defaultIconSize*_scale,0,c_white,_percent);
	}
	
	if instance_exists(oRender) {
		surface_reset_target();
		surface_set_target(oRender.guiSurface);
	}
	
	if sprite_exists(global.playerSprites[winOrder[0]][0])
		draw_sprite_ext(global.playerSprites[winOrder[0]][1],0,_hexX-defaultIconSize/2,700-defaultIconSize/2,1,1,0,c_white,animcurve_channel_evaluate(xMoveCurve,median(textPercent-2,1,0)));
	
	//1st
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(global.colours[winOrder[0]]);
	gpu_set_tex_filter(false);
	draw_set_alpha(animcurve_channel_evaluate(xMoveCurve,min(textPercent,1)));
	draw_text_transformed(_hexX,220,"WINNER",1.5,1.5,0);
	
	draw_line_width(_hexX-200,280,_hexX+200,280,5);
	draw_set_alpha(animcurve_channel_evaluate(xMoveCurve,median(textPercent-1,1,0)));
	
	_textScale = min(1.5,460/string_width(global.names[winOrder[0]]))
	draw_set_valign(fa_middle);
	draw_text_transformed(_hexX,345,global.names[winOrder[0]],_textScale,max(1.2,_textScale),0);
	
	draw_set_valign(fa_top);
	draw_text_transformed(_hexX,410,string(global.scores[winOrder[0]] div 60)+":"+string_replace(string_format(global.scores[winOrder[0]] % 60,2,2)," ","0"),1.5,1.5,0);
	
	gpu_set_tex_filter(true);
	draw_set_alpha(1);
	
	for(var i = 0; i < 3; i++) {
		_percent = animcurve_channel_evaluate(xRecordCurve,min(1,recordPercent-0.8*(2-i)));
		_player = winOrder[i+1];
		if global.scores[_player] == 0 continue;
		_scale = 1 - (i != 0) * 0.15 - (i == 2) * 0.1;
		_x = _panelX - 1200 + 250 - 50 * i - 100 / _scale * (1 - _percent);
		_y = 280+200*i+30*(i != 0);
		draw_set_alpha(_percent);
		
		if sprite_exists(global.playerSprites[_player][0])
			draw_sprite_ext(global.playerSprites[_player][0],0,_x+25*_scale,_y+15*_scale,100/defaultIconSize*_scale,100/defaultIconSize*_scale,0,c_white,_percent);
		
		draw_set_colour(global.colours[_player]);
		gpu_set_tex_filter(false);
		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);
		draw_text_transformed(_x+550*_scale	,_y+120*_scale,string(global.scores[_player] div 60)+":"+string_replace(string_format(global.scores[_player] % 60,2,2)," ","0"),_scale,_scale,0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		_textScale = min(1,470/string_width(global.names[_player])) * 0.9 * _scale;
		
		draw_text_transformed(_x+140*_scale,_y+20*_scale,global.names[_player],_textScale,_textScale,0);
		
		gpu_set_tex_filter(true);
	}
	
	draw_set_alpha(1);
}