/// @desc Change Colour

image_blend = merge_color(c_white,colour,colourAmount);
colourAmount = ApproachFade(colourAmount,0,0.04,0.9);
scale = Approach(scale,1,0.05);