/// @desc

enableLive;

draw_set_font(GuiFont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _col = [
	#0054FF,
	#FF0D00,
	#00FF00,
	#FF7000
];

var _players = 4;
for(var i = 0; i < _players; i++) {
	var _scale = min(1,440/string_width(names[i]));
	var _x = 1920/5*(i+1)+80*(i-1.5);
	draw_text_transformed_color(_x,20,names[i],_scale,1,0,_col[i],_col[i],c_white,c_white,1);
	draw_text(_x,60,"0000");
}