/// @desc Move

if !rollback_game_running exit;

var _input = rollback_get_input();

if _input.mouseLeft {
	drawingLine = true;
	mouseX = _input.mouseX;
	mouseY = _input.mouseY;
	
	if _input.mouseLeft_pressed {
		mouseClickX = mouseX;
		mouseClickY = mouseY;
	}
	
	launchDist = point_distance(mouseX,mouseY,mouseClickX,mouseClickY);
	if launchDist > 0 launchDir = point_direction(mouseX,mouseY,mouseClickX,mouseClickY);
} else if drawingLine {
	drawingLine = false;
	var _speed = launchSpd * min(1,launchDist/launchLenMax);
	hSpd = lengthdir_x(_speed,launchDir) + hSpd / 2;
	vSpd = lengthdir_y(_speed,launchDir) + vSpd / 2;
}

image_angle = ApproachCircleEase(image_angle,launchDir,40,0.6);

if x < sprite_width/2 hSpd = abs(hSpd);
else if x >= room_width-sprite_width/2 hSpd = -abs(hSpd);
if y < sprite_width/2 vSpd = abs(vSpd);
else if y >= room_height-sprite_width/2 vSpd = -abs(vSpd);


var _dir = point_direction(0,0,hSpd,vSpd);
hSpd = Approach(hSpd,0,abs(lengthdir_x(FRIC,_dir)));
vSpd = Approach(vSpd,0,abs(lengthdir_y(FRIC,_dir)));

hSpd = min(abs(hSpd),abs(lengthdir_x(maxSpd,_dir)))*sign(hSpd);
vSpd = min(abs(vSpd),abs(lengthdir_y(maxSpd,_dir)))*sign(vSpd);

if !drawingLine and hSpd != 0 and vSpd != 0 launchDir = _dir;

x += hSpd;
y += vSpd;