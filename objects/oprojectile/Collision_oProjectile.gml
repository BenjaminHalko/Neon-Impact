/// @desc

if noProjectileCollision exit;

var _otherSpd = sqrt(sqr(other.hSpd) + sqr(other.vSpd));

if sqrt(sqr(hSpd) + sqr(vSpd)) >= _otherSpd {
	other.colour = colour;
	Collision(other,1);
}