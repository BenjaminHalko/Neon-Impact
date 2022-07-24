function Collision(_collider,_restitution) {
	_restitution = 2;
	var _dist = point_distance(x,y,_collider.x,_collider.y);
	
	var _x = (_collider.x-x) * 1/_dist;
	var _y = (_collider.y-y) * 1/_dist;
	
	
	var _v1 = hSpd *_x + vSpd * _y;
	var _v2 = _collider.hSpd * _x +  _collider.vSpd * _y;
	
	if sign(_v1) != 1 and sign(_v2) != 1 return;
	
	//Correct Positions
	var _corr = (sprite_width / 2 + _collider.sprite_width / 2 - _dist) / 2;
	x -= _x * _corr;
	y -= _y * _corr;
	
	if _collider.object_index != oWall {
		_collider.x += _x * _corr;
		_collider.y += _y * _corr;
	}
	
	//Calculate Velocity
	var _m1 = mass;
	var _m2 = _collider.mass;

	var _len1 = (_m1 * _v1 +_m2 * _v2 - _m2 * (_v1 - _v2) * _restitution) / (_m1 + _m2);
	var _len2 = (_m1 * _v1 +_m2 * _v2 - _m1 * (_v2 - _v1) * _restitution) / (_m1 + _m2);
	
	hSpd += _x * (_len1 - _v1);
	vSpd += _y * (_len1 - _v1);
	
	_collider.hSpd += _x * (_len2 - _v2);
	_collider.vSpd += _y * (_len2 - _v2);
	
	//Change Launch Dir
	if object_index != oPlayer or !drawingLine launchDir = point_direction(0,0,hSpd,vSpd);
	if _collider.object_index != oWall _collider.launchDir = point_direction(0,0,hSpd,vSpd);
}