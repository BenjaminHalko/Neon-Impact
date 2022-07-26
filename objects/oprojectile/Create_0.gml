/// @desc Initalize Projectile

hSpd = 0;
vSpd = 0;
mass = sprite_width / 96;
maxSpd = 60;

colour = c_white;
launchDir = irandom(360);
image_angle = launchDir;

noProjectileCollision = false;
dead = false;