var _breathe = 0.05*abs(sin(4*degtorad(local_timer)+pv));

draw_sprite_ext(sprite_index,image_index,x,y,z.zoom*image_xscale,z.zoom+_breathe,0,c_white,0.3);

draw_set_halign(fa_center);

if selected{
	draw_text(x,y-50,name);
	
	var _disp_task = 
	is_instanceof(task,TaskObj) ? string_concat("[ ",task.title," ]") : 
	(path_position != 1 ? string_concat("[ Moving ]") : "[ ... ]");
	
	var _flash = true;
	if (_disp_task == "[ ... ]" && sin(degtorad(local_timer*4)) < 0){_flash = false;}
	
	if (_flash){draw_text(x,y-62,_disp_task);}
	
	if (path_position != 1){
		var _tpath = path_add();
		path_add_point(_tpath,x,y,100);
		path_add_point(_tpath,path_get_point_x(path,1),path_get_point_y(path,1),100);
		
		draw_path(_tpath,0,0,true);
		
		path_delete(_tpath);
	}
}
else if hover{
	draw_text(x,y-50,name);
}

draw_set_halign(fa_left);