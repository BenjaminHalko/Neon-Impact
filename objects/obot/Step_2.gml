/// @desc Move

if PAUSE or !GLOBAL.roundStart exit;

var _dir = point_direction(0,0,hSpd,vSpd);
hSpd = Approach(hSpd,0,abs(lengthdir_x(FRIC,_dir)));
vSpd = Approach(vSpd,0,abs(lengthdir_y(FRIC,_dir)));

hSpd = min(abs(hSpd),abs(lengthdir_x(maxSpd,_dir)))*sign(hSpd);
vSpd = min(abs(vSpd),abs(lengthdir_y(maxSpd,_dir)))*sign(vSpd);
timer = 80;

if timer <= 60 and GLOBAL.roundStart and !oGameManager.stopTimer {
	launchDirSpd += 0.5;
	launchDir -= launchDirSpd;
	if allowGrow scale += 0.01;
	else scale = ApproachFade(scale,1,0.1,0.5);
} else scale = ApproachFade(scale,1,0.1,0.5);

image_blend = merge_color(global.colours[4],c_white,max(0,(scale-1)/2));

with(oPlayer) {
	if visible {
		other.target = id;
		break;
	}
}

if timer == 0 {
	launchDirSpd = 0;
	if instance_exists(target) and target.visible launchDir = point_direction(x,y,target.x,target.y);
	hSpd = lengthdir_x(25,launchDir);
	vSpd = lengthdir_y(25,launchDir);
	timer = max(85,maxTime - fast);
	fast += 1;
	allowGrow = false;
}

if scale == 1 allowGrow = true;

if !oGameManager.stopTimer and GLOBAL.roundStart timer--;

if x < collisionWidth/2 hSpd = abs(hSpd);
else if x >= room_width-collisionWidth/2 hSpd = -abs(hSpd);
if y < collisionWidth/2 vSpd = abs(vSpd);
else if y >= room_height-collisionWidth/2 vSpd = -abs(vSpd);

x += hSpd;
y += vSpd;

image_angle = ApproachCircleEase(image_angle,launchDir,40,0.6);