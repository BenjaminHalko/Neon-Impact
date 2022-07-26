/// @desc Fade

if mode {
	linePercent = ApproachFade(linePercent,2,0.03,0.8);
	if linePercent > 1.6 and abs(1 - fadePercent % 2) > 0.95 fadePercent = 0;
	else fadePercent += lerp(1 / flashSpd, 0.1, linePercent/2);
	ScreenShake(8*(2-linePercent)/2,10,x,y);
	if linePercent == 2 instance_destroy();
} else ScreenShake(12,30,x,y);