function path_auto_turn(_path,_inst){
	if (path_get_point_x(_path,1) < _inst.x){
		_inst.image_xscale = -1;
	}
	else{
		_inst.image_xscale = 1;
	}
}

function p_idle(_inst){
	var _path = _inst.path;
	path_clear_points(_path);
	
	path_add_point(_path,_inst.x,_inst.y,50);
	
	path_add_point(
	_path,
	clamp(_inst.x+random_range(-18,18),20,room_width-20),
	clamp(_inst.y+random_range(-18,18),60,room_height-20),
	50);
	
	path_auto_turn(_path,_inst);
	with _inst{
		path_start(_path,1,path_action_stop,true);
	}
}

function p_to_cursor(_inst){
	var _path = _inst.path;
	path_clear_points(_path);
	
	path_add_point(_path,_inst.x,_inst.y,50);
	
	path_add_point(
	_path,
	clamp(mouse_x,20,room_width-20),
	clamp(mouse_y,60,room_height-20),
	100);
	
	path_auto_turn(_path,_inst);
	with _inst{
		path_start(_path,1,path_action_stop,true);
	}
}

function p_to_point(_inst,_x,_y){
	var _path = _inst.path;
	path_clear_points(_path);
	
	path_add_point(_path,_inst.x,_inst.y,50);
	
	path_add_point(
	_path,
	clamp(_x,20,_x-20),
	clamp(_y,60,_y-20),
	100);
	
	path_auto_turn(_path,_inst);
	with _inst{
		path_start(_path,1,path_action_stop,true);
	}
}