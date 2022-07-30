/// @desc

if noProjectileCollision exit;

var _otherSpd = sqrt(sqr(other.hSpd) + sqr(other.vSpd));

if sqrt(sqr(hSpd) + sqr(vSpd)) >= _otherSpd {
	if other.object_index != oBot other.colour = colour;
	Collision(other,1);
}