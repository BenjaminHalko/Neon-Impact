/// @desc Move

if PAUSE exit;

if hSpd != 0 and vSpd != 0 {
	image_blend = merge_color(c_white,colour,min(1,sqrt(sqr(hSpd) + sqr(vSpd))/2));

	var _dir = point_direction(0,0,hSpd,vSpd);
	hSpd = Approach(hSpd,0,abs(lengthdir_x(FRIC,_dir)));
	vSpd = Approach(vSpd,0,abs(lengthdir_y(FRIC,_dir)));

	hSpd = min(abs(hSpd),abs(lengthdir_x(maxSpd,_dir)))*sign(hSpd);
	vSpd = min(abs(vSpd),abs(lengthdir_y(maxSpd,_dir)))*sign(vSpd);

	launchDir = _dir;

	if x < collisionWidth/2 hSpd = abs(hSpd);
	else if x >= room_width-collisionWidth/2 hSpd = -abs(hSpd);
	if y < collisionWidth/2 vSpd = abs(vSpd);
	else if y >= room_height-collisionWidth/2 vSpd = -abs(vSpd);

	x += hSpd;
	y += vSpd;
} else image_blend = c_white;

image_angle = ApproachCircleEase(image_angle,launchDir,40,0.6);
if noProjectileCollision and !place_meeting(x,y,oProjectile) noProjectileCollision = false;