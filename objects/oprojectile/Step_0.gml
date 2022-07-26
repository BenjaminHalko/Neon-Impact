/// @desc Move

if !rollback_game_running exit;

image_blend = merge_color(c_white,colour,min(1,sqrt(sqr(hSpd) + sqr(vSpd))/2));
image_angle = ApproachCircleEase(image_angle,launchDir,40,0.6);

var _dir = point_direction(0,0,hSpd,vSpd);
hSpd = Approach(hSpd,0,abs(lengthdir_x(FRIC,_dir)));
vSpd = Approach(vSpd,0,abs(lengthdir_y(FRIC,_dir)));

hSpd = min(abs(hSpd),abs(lengthdir_x(maxSpd,_dir)))*sign(hSpd);
vSpd = min(abs(vSpd),abs(lengthdir_y(maxSpd,_dir)))*sign(vSpd);

if hSpd != 0 and vSpd != 0 launchDir = _dir;

if x < sprite_width/2 hSpd = abs(hSpd);
else if x >= room_width-sprite_width/2 hSpd = -abs(hSpd);
if y < sprite_width/2 vSpd = abs(vSpd);
else if y >= room_height-sprite_width/2 vSpd = -abs(vSpd);

x += hSpd;
y += vSpd;

if noProjectileCollision and !place_meeting(x,y,oProjectile) noProjectileCollision = false;