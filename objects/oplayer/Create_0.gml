/// @desc

colours = [
	#00FFFF,
	#FF0048,
	#55FF00,
	#FFC700
];

mouseClickX = 0;
mouseClickY = 0;
mouseX = 0;
mouseY = 0;
drawingLine = false;
launchDir = 0;
launchDist = 0;
launchLenMax = 400;
launchSpd = 20;

x = room_width/2;
y = room_height/2;

//Speed
mass = 1;

fric = 0.08;
hSpd = 0;
vSpd = 0;

for(var i = 0; i < 3; i++) {
	instance_find(oDummy,i).index = i + 1;
}