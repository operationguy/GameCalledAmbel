function get_max_stack(_iid){
	static map = {
	}
	
	if !struct_exists(map,string(_iid)){
		return 99;
	}
	else{
		return map[$ string(_iid)];
	}
}