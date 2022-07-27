/// @desc Initialize Wall

enableLive;

wallPercent = 1;
surface = surface_create(room_width,room_height);

rotation = 0;
maxLen = room_width/2-40;
maxLenMin = maxLen - 500;
minLen = 1600;
minLenMin = 900;

in = true;

curve = animcurve_get_channel(DoomCurve,0);

x = room_width/2;
y = room_height/2;

xTo = x;
yTo = y;

xstart = x;
ystart = y;