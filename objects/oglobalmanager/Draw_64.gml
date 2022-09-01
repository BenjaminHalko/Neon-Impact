/// @desc

if qualitySign != 0 {
	var _text = ["Best Quality","Mid Quality","Low Quality"];
	draw_set_font(GuiFont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(min(1,qualitySign/30));
	draw_text(200,1000,_text[oRender.disable]);
	draw_set_alpha(1);
}