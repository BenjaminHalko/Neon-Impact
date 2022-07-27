/// @desc Initalize Projectile

hSpd = 0;
vSpd = 0;
mass = sprite_width / 96;
maxSpd = 60;

collisionWidth = round(bbox_right-bbox_left);

colour = c_white;
launchDir = irandom(360);
image_angle = launchDir;

noProjectileCollision = false;
dead = false;