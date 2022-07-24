function Collision(_collider,_restitution) {
	var _dist = point_distance(x,y,_collider.x,_collider.y);
	
	var _x = (_collider.x-x) * 1/_dist;
	var _y = (_collider.y-y) * 1/_dist;
	
	
	var _m2 = _collider.mass;
	
	//Correct Positions
	var _corr = (sprite_width / 2 + _collider.sprite_width / 2 - _dist) / 2;
	x -= _x * _corr;
	y -= _y * _corr;
	
	if _collider.object_index != oWall {
		_collider.x += _x * _corr;
		_collider.y += _y * _corr;
	}
		
	var _v1 = hSpd *_x + vSpd * _y;
	var _v2 = _collider.hSpd * _x +  _collider.vSpd * _y;

	var _len1 = (mass * _v1 +_m2 * _v2 - _m2 * (_v1 - _v2) * _restitution) / (mass + _m2);
	var _len2 = (mass * _v1 +_m2 * _v2 - mass * (_v2 - _v1) * _restitution) / (mass + _m2);
	
	hSpd += _x * (_len1 - _v1);
	vSpd += _y * (_len1 - _v1);
	
	_collider.hSpd += _x * (_len2 - _v2);
	_collider.vSpd += _y * (_len2 - _v2);
	
	//Change Launch Dir
	if object_index != oPlayer or !drawingLine launchDir = point_direction(0,0,hSpd,vSpd);
	if _collider.object_index != oWall _collider.launchDir = point_direction(0,0,hSpd,vSpd);
}