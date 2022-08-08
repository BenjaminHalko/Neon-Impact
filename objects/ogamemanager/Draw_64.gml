/// @desc Draw Time + Other On Screen Things

if !global.title {
	draw_set_font(GuiFont);

	if !GLOBAL.gameOver {

		var _alpha;
		with(oPlayer) {
			if (dead or point_in_rectangle(x,y,CamX-sprite_width/2,CamY-sprite_width/2,CamX+CamW+sprite_width/2,CamY+CamH+sprite_width/2)) continue;

			_alpha = 0.9;
			if instance_exists(deadObject) {
				if deadObject.mode draw_set_colour(merge_color(global.colours[4],global.colours[index],abs(1 - deadObject.fadePercent % 2)));
				else draw_set_colour(global.colours[(deadObject.number % 2) ? index : 4]);
				_alpha *= min(1,2 - deadObject.linePercent);
			} else if deadObject != noone _alpha = 0;
			else draw_set_colour(global.colours[index]);
	
			var _len = 0;
			var _dir = point_direction(CamW/2,CamH/2,x-CamX,y-CamY);
	
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
		
		with(oBot) {
			if (point_in_rectangle(x,y,CamX-sprite_width/2,CamY-sprite_width/2,CamX+CamW+sprite_width/2,CamY+CamH+sprite_width/2)) continue;

			_alpha = 0.9;
			draw_set_colour(global.colours[4]);
	
			var _len = 0;
			var _dir = point_direction(CamW/2,CamH/2,x-CamX,y-CamY);
	
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
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_white);

		if SPECTATING and oCamera.spectatingWait == 0 {
			draw_set_valign(fa_bottom);
			draw_set_alpha(Wave(0.5,0.7,4,0));
			draw_text(960,1060,"SPECTATING");
			draw_set_alpha(1);
			draw_set_valign(fa_top);
		}

		var _time = GLOBAL.time;

		if GLOBAL.scores[oGlobalManager.playerNum] != 0 and oGlobalManager.number != oGlobalManager.maxNum {
			_time = GLOBAL.scores[oGlobalManager.playerNum];
			if oGlobalManager.number % 2 exit;
		}

		draw_text(960,20,string(_time div 60)+":"+string_replace(string_format(_time % 60,2,2)," ","0"));
	} else {
		var _x, _y, _scale, _percent, _sprite, _player, _width, _textScale, _hexX, _panelX;
	
		var _texFilter = gpu_get_tex_filter();
	
		if !oRender.disable {
			surface_reset_target();
			surface_set_target(oRender.viewSurface);
		}
	
		//Panels
		draw_set_alpha(0.3);
		draw_set_color(global.colours[4]);
		_panelX = 1155*animcurve_channel_evaluate(xMoveCurve,panelXPercent)-5;
		draw_triangle(_panelX,-1,_panelX-600,-1,_panelX-600,1080,false);
		draw_rectangle(0,0,_panelX-600-(os_type == os_operagx),1080,false);
		draw_set_alpha(1);
	
		_hexX = lerp(2250,1500,animcurve_channel_evaluate(xMoveCurve,min(hexPercent,1))*animcurve_channel_evaluate(xMoveCurve,panelXPercent));
		_y = 150 * animcurve_channel_evaluate(yHexCurve,max(hexPercent-1,0));
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
		var _global = oGlobalManager.globalScores;
		for(var i = 0; i < 3; i++) {
			_player = winOrder[i+1];
			if GLOBAL.scores[_player] == 0 and (!alone or array_length(_global) <= i) continue;
			_percent = animcurve_channel_evaluate(xRecordCurve,min(1,recordPercent-0.8*(2-i)))
			_scale = 1 - (i != 0) * 0.15 - (i == 2) * 0.1;
			_x = _panelX - 1200 + 250 - 50 * i - 100 / _scale * (1 - _percent);
			_y = 280+200*i+30*(i != 0);
		
			draw_sprite_ext(sRanking,0,_x+lengthdir_x(20,-30),_y+lengthdir_y(20,-30),_scale,_scale,0,global.colours[_player],_percent);
			draw_sprite_ext(sRanking,0,_x,_y,_scale,_scale,0,c_black,_percent);
			
			if !sprite_exists(alone ? _global[i].sprite : global.playerSprites[_player][0]) {
				draw_sprite_ext(sDefaultIcons,_player,_x+25*_scale,_y+15*_scale,100/defaultIconSize*_scale,100/defaultIconSize*_scale,0,c_white,_percent);
			}
		}
	
		if !oRender.disable {
			surface_reset_target();
			surface_set_target(oRender.guiSurface);
		}
	
		if sprite_exists(global.playerSprites[winOrder[0]][1])
			draw_sprite_ext(global.playerSprites[winOrder[0]][1],0,_hexX-defaultIconSize/2,700-defaultIconSize/2,1,1,0,c_white,animcurve_channel_evaluate(xMoveCurve,median(textPercent-2,1,0)));
	
		//1st
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(global.colours[winOrder[0]]);
		gpu_set_tex_filter(false);
		draw_set_alpha(animcurve_channel_evaluate(xMoveCurve,min(textPercent,1)));
		draw_text_transformed(_hexX,220,alone ? "SCORE" : "WINNER",1.5,1.5,0);
	
		draw_line_width(_hexX-200,280,_hexX+200,280,5);
		draw_set_alpha(animcurve_channel_evaluate(xMoveCurve,median(textPercent-1,1,0)));
	
		_textScale = min(1.5,460/string_width(GLOBAL.names[winOrder[0]]))
		draw_set_valign(fa_middle);
		draw_text_transformed(_hexX,345,GLOBAL.names[winOrder[0]],_textScale,max(1.2,_textScale),0);
	
		draw_set_valign(fa_top);
		draw_text_transformed(_hexX,410,string(GLOBAL.scores[winOrder[0]] div 60)+":"+string_replace(string_format(GLOBAL.scores[winOrder[0]] % 60,2,2)," ","0"),1.5,1.5,0);
		draw_set_alpha(1);
	
		//Next Round In:
		draw_set_color(c_black);
		draw_set_halign(fa_left);
		draw_text_transformed(_panelX-1096,44,"Next Round In: "+string_replace(string_format(floor(max(0,timeLeft)),2,0)," ","0"),1.5,1.5,0);
		if GLOBAL.numPlayers == 1 draw_text(_panelX-996,104,"Or Click Anywhere");

		draw_set_color(global.colours[4]);
		draw_text_transformed(_panelX-1100,40,"Next Round In: "+string_replace(string_format(floor(max(0,timeLeft)),2,0)," ","0"),1.5,1.5,0);
		if GLOBAL.numPlayers == 1 draw_text(_panelX-1000,100,"Or Click Anywhere");

		gpu_set_tex_filter(_texFilter);
	
		for(var i = 0; i < 3; i++) {
			_percent = animcurve_channel_evaluate(xRecordCurve,min(1,recordPercent-0.8*(2-i)));
			_player = winOrder[i+1];
			if GLOBAL.scores[_player] == 0 and (!alone or array_length(_global) <= i) continue;
			_scale = 1 - (i != 0) * 0.15 - (i == 2) * 0.1;
			_x = _panelX - 1200 + 250 - 50 * i - 100 / _scale * (1 - _percent);
			_y = 280+200*i+30*(i != 0);
			draw_set_alpha(_percent);
		
			var _score = GLOBAL.scores[_player];
			var _name = GLOBAL.names[_player];
		
			if alone {
				_score = _global[i].points;
				_name = _global[i].username;
				if sprite_exists(_global[i].sprite) draw_sprite_ext(_global[i].sprite,0,_x+25*_scale,_y+15*_scale,100/defaultIconSize*_scale,100/defaultIconSize*_scale,0,c_white,_percent);
			} else if sprite_exists(global.playerSprites[_player][0])
				draw_sprite_ext(global.playerSprites[_player][0],0,_x+25*_scale,_y+15*_scale,100/defaultIconSize*_scale,100/defaultIconSize*_scale,0,c_white,_percent);
		
			draw_set_colour(global.colours[_player]);
			gpu_set_tex_filter(false);
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text_transformed(_x+550*_scale	,_y+120*_scale,string(_score div 60)+":"+string_replace(string_format(_score % 60,2,2)," ","0"),_scale,_scale,0);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		
			_textScale = min(1,470/string_width(_name)) * 0.9 * _scale;
		
			draw_text_transformed(_x+140*_scale,_y+20*_scale,_name,_textScale,_textScale,0);
		
			gpu_set_tex_filter(_texFilter);
		}
	
		draw_set_alpha(1);
	}
}

//Transition
if transitionPercent != 1 {
	var _drawSurface = function() {
		surface_set_target(oGlobalManager.transitionSurfacePong);
		draw_clear_alpha(c_black,0);
		
		var _wallLen = lerp(-45,1600,median(0,1,transitionPercent));
		var _x = 960;
		var _y = 540;
		var _len = max(0,_wallLen);
		
		if transitionChange {
			for(var i = 0; i < 6; i++) {
				draw_triangle(_x,_y,_x+lengthdir_x(_len,i*360/6+transitionDir),_y+lengthdir_y(_len,i*360/6+transitionDir),_x+lengthdir_x(_len,(i+1)*360/6+transitionDir),_y+lengthdir_y(_len,(i+1)*360/6+transitionDir),false);
			}
			
			gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
			draw_surface(oGlobalManager.transitionSurfacePing,0,0);
			gpu_set_blendmode(bm_normal);
		} else {
			draw_surface(oGlobalManager.transitionSurfacePing,0,0);
			gpu_set_blendmode(bm_subtract);
			draw_set_color(c_black);
			gpu_set_blendmode(bm_subtract);
			for(var i = 0; i < 6; i++) {
				draw_triangle(_x,_y,_x+lengthdir_x(_len,i*360/6+transitionDir),_y+lengthdir_y(_len,i*360/6+transitionDir),_x+lengthdir_x(_len,(i+1)*360/6+transitionDir),_y+lengthdir_y(_len,(i+1)*360/6+transitionDir),false);
			}
			gpu_set_blendmode(bm_normal);
		}
		
		//Lines
		draw_set_color(make_color_hsv(Wave(260,265,5,0)/360*255,255,255));
			var _width = 45+min(0,_wallLen);
			_len += _width;
		for(var i = 0; i < 6; i++) {
			draw_line_width(
	
			_x+lengthdir_x(_len,i*360/6+transitionDir)-lengthdir_x(_width/2,(i-1)*360/6+90+transitionDir),
			_y+lengthdir_y(_len,i*360/6+transitionDir)-lengthdir_y(_width/2,(i-1)*360/6+90+transitionDir),
			_x+lengthdir_x(_len,(i+1)*360/6+transitionDir)-lengthdir_x(_width/2,(i-1)*360/6+90+transitionDir),
			_y+lengthdir_y(_len,(i+1)*360/6+transitionDir)-lengthdir_y(_width/2,(i-1)*360/6+90+transitionDir),
	
			_width);
		}
		surface_reset_target();
		draw_surface(oGlobalManager.transitionSurfacePong,0,0);
	}
	
	if !oRender.disable {
		surface_reset_target();
		surface_set_target(oRender.viewSurface);
		_drawSurface();
		surface_reset_target();
		surface_set_target(oRender.guiSurface);
		gpu_set_blendmode(bm_subtract);
		draw_surface_ext(oGlobalManager.transitionSurfacePong,0,0,1,1,0,c_black,1);
		gpu_set_blendmode(bm_normal);
	} else _drawSurface();
}

draw_set_halign(oGlobalManager.playerNum ? fa_left : fa_right);
draw_text(oGlobalManager.playerNum ? 96 : 1920 - 96,200,string(oGlobalManager.ran));