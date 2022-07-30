/// @desc Change Colour

if PAUSE exit;

if colourAmount != 0 {
	colourAmount = ApproachFade(colourAmount,0,0.04,0.9);
	image_blend = merge_color(c_white,colour,colourAmount);
}

scale = Approach(scale,1,0.05);