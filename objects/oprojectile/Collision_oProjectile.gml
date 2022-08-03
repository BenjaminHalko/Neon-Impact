/// @desc

if noProjectileCollision or other.noProjectileCollision or !SYNC exit;

var _otherSpd = sqrt(sqr(other.hSpd) + sqr(other.vSpd));

if sqrt(sqr(hSpd) + sqr(vSpd)) >= _otherSpd {
	if other.object_index != oBot other.colour = colour;
	Collision(other,1);
	PlayAudio(snProjectileBonk,0.15,x,y,random_range(0.3,0.6)/mass);
}