/// @desc Change Colour

if PAUSE exit;

x = room_width/2+lengthdir_x(dist,dir+GLOBAL.time*80000/sqr(dist/15));
y = room_height/2+lengthdir_y(dist,dir+GLOBAL.time*80000/sqr(dist/15));

if colourAmount != 0 {
	colourAmount = ApproachFade(colourAmount,0,0.04,0.9);
	image_blend = merge_color(c_white,colour,colourAmount);
}

scale = Approach(scale,1,0.05);