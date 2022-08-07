/// @desc Draw Quality

if qualitySign != 0 {
	draw_set_alpha(min(1,qualitySign/30));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	var _type = ["BEST", "MID", "LOW"];
	draw_text(96,1000,_type[oRender.disable]+" QUALITY");
	draw_set_alpha(1);
}