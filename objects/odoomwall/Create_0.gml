/// @desc Initialize Wall

wallPercent = 1;
surface = surface_create(room_width,room_height);

startMaxLen = room_width/2-100;
startMinLen = 2000;

rotation = 0;
maxLen = 0;
maxLenMax = 800;
minLen = 0;
minLenMax = 500;

wallSpd = 0;

wallSpdArray = [0.0014,0.001,0.0007,0.0005];

wallLen = startMaxLen;
disappear = 0;

in = true;

curve = animcurve_get_channel(DoomCurve,0);

x = room_width/2;
y = room_height/2;

xTo = x;
yTo = y;

xstart = x;
ystart = y;

debug = false;