/// @desc

#macro FRIC 0.15
#macro CamX oCamera.camX
#macro CamY oCamera.camY

#macro CHALLENGEID ""

global.colours = [ #00FFFF, #FF0048, #55FF00, #FF9C00, #5500FF ];

instance_create_layer(0,0,layer,oGameManager);

finalTime = 0;
flash = 0;
number = 0;
maxNum = 12;