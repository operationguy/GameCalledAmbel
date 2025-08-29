if !global.reading{on_click(func_l,,func_r);}

depth = base_depth - y;

if selected{
	if mouse_check_button_released(mb_right){
		enqueue_movement(new Movement(p_to_cursor,self.id,true));
		dequeue_movement();
	}
}

if !global.paused{
	local_timer++;
	
	food = perc_tick(food,120,-0.01);
	rest = perc_tick(rest,280,-0.01);
	
	// forget skill exp over time (cannot delevel)
	if local_tick(3600){
		struct_foreach(mind.subparts,function(_key,_val){
			_val.tick_forget();
		});
	}
	
	// check if not moving
	if (path_position == 1){
		// idle around if nothing to do
		if no_tasks_or_movement(){
			if local_tick(160){
				enqueue_movement(new Movement(p_idle,self.id,true));
			}
		}
		// dequeue priority movemenet first, then perform tasks
		else if !dequeue_movement(){
			perform_task();
		}
	}
	
	path_speed = p_spd;
}
else{
	path_speed = 0;
}