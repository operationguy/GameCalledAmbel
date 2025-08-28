if !global.reading{on_click(func_l,,func_r);}

depth = base_depth - y;

if !global.paused{
	local_timer++;
	
	food = perc_tick(food,120,-0.01);
	rest = perc_tick(rest,280,-0.01);
	
	if local_tick(160){
		p_idle(path);
	}
}