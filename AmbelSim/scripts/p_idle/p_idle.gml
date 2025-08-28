function p_idle(_path){
	path_clear_points(_path);
	
	path_add_point(_path,x,y,50);
	
	path_add_point(
	_path,
	clamp(x+random_range(-18,18),20,room_width-20),
	clamp(y+random_range(-18,18),60,room_height-20),
	50);
	
	if (path_get_point_x(_path,1) < x){
		image_xscale = -1;
	}
	else{
		image_xscale = 1;
	}
	
	path_start(_path,1,path_action_stop,true)
}