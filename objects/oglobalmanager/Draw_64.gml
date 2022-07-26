/// @desc

draw_set_font(GuiFont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _time = global.time;

if finalTime != 0 and number < maxNum {
	_time = finalTime;
	if number % 2 exit;
}

draw_text(960,20,string(_time div 60)+":"+string_replace(string_format(_time % 60,2,2)," ","0"));