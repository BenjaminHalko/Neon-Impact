/// @desc

life -= 0.005;
if life <= 0 instance_destroy();
image_xscale = lerp(0.2,1,life);
image_yscale = image_xscale;