function empty_item(){
	return instance_create_layer(-999,-999,"Objects",obj_item);
}

function is_empty_item(_e){
	return _e.iid == -1;
}