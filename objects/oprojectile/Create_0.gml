/// @desc Initalize Projectile

hSpd = 0;
vSpd = 0;
mass = sprite_width / 96;
maxSpd = 60;

collisionWidth = 124*image_xscale;

colour = c_white;
launchDir = random(360);
image_angle = launchDir;

noProjectileCollision = false;
dead = false;

created = false;
outSideOfWall = true;