function caption(_x, _y, _title = "", _color_t = #FFFFFF, _desc = "", _color_d = #C6C6C6, _align = fa_left){
	return instance_create_layer(_x,_y,"InfoboxText",obj_infoobj,{
		title : _title,
		desc : _desc,
		align : _align,
		color_t : _color_t,
		color_d : _color_d,
		cx : 0,
		cy : 0
	});
}

function obj(_x,_y,_data){
	return instance_create_layer(_x,_y,"InfoboxText",obj_infoobj,_data);
}