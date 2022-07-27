/// @desc Draw Time + Other On Screen Things

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