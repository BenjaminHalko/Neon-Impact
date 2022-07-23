/// @desc

var _dir = point_direction(0,0,hSpd,vSpd);
hSpd = Approach(hSpd,0,abs(lengthdir_x(fric,_dir)));
vSpd = Approach(vSpd,0,abs(lengthdir_y(fric,_dir)));

x += hSpd;
y += vSpd;