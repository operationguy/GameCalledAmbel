enum ITEM{
	EMPTY = -1,
	MUSHROOM = 0,
	WOOD = 1,
	BERRY = 2
}

function create_item(_iid,_x,_y){
	return instance_create_layer(_x,_y,"Objects",obj_item,{
		image_index : _iid,
		iid : _iid
	});
}