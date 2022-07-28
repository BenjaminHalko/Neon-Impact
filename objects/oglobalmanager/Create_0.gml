/// @desc Initialize Non-Synced Variables

#macro FRIC 0.15
#macro CamX oCamera.camX
#macro CamY oCamera.camY
#macro PAUSE (global.multiplayer and !rollback_game_running)
#macro SYNC (!global.multiplayer or rollback_sync_on_frame())

#macro CHALLENGEID "d655ef5e-ed52-4228-ac58-292edf12ec3d"

global.colours = [ #00FFFF, #FF0048, #55FF00, #FF9C00, #5500FF ];
global.multiplayer = true;

instance_create_layer(0,0,layer,oCamera);
instance_create_layer(0,0,layer,oGameManager);

flash = 0;
number = 0;
maxNum = 12;

playerNum = 0;