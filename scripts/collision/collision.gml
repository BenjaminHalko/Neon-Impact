function Collision(_collider,_restitution) {
	var _dist = point_distance(x,y,_collider.x,_collider.y);
	
	var _x = (_collider.x-x) * 1/_dist;
	var _y = (_collider.y-y) * 1/_dist;
	
	
	var _v1 = dot_product(hSpd,vSpd,_x,_y);
	var _v2;
	
	if _collider.object_index != oWall {
		_v2 = dot_product(_collider.hSpd,_collider.vSpd,_x,_y);
	} else _v2 = 0;
	
	if sign(_v1) != 1 and sign(_v2) != 1 return;
	
	//Correct Positions
	var _corr = (collisionWidth / 2 + _collider.collisionWidth / 2 - _dist) / 2;
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
	
	if object_index != oPlayer or !drawingLine launchDir = point_direction(0,0,hSpd,vSpd);
	if _collider.object_index != oWall {
		_collider.vSpd += _y * (_len2 - _v2);
		_collider.launchDir = point_direction(0,0,hSpd,vSpd);
	}
}