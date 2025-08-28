function on_click(_func_l = function(_q){}, _params_l = {}, _func_r = function(_p){}, _params_r = {}){
	if point_in_rectangle(
	mouse_x,
	mouse_y,
	bbox_left,
	bbox_top,
	bbox_right,
	bbox_bottom){
		hover = true;
		z.ac = clamp(z.ac+0.03,0,1);
		z.zoom = z.base*animcurve_channel_evaluate(animcurve_get_channel(ac_bounce,"curve1"),z.ac);
		
		if mouse_check_button_released(mb_left){
			if !toggle{z.ac = 0;}
			toggled = (toggle && !toggled);
			_func_l(_params_l);
		}
		
		else if mouse_check_button_released(mb_right){
			z.ac = 0;
			_func_r(_params_r);
		}
	}
	else{
		hover = false;
		z.ac = clamp(z.ac-0.03,0,1);
		z.zoom = (z.zoom*4+z.base)/5;
	}
	
	held = hover && (mouse_check_button(mb_left) || mouse_check_button(mb_right));
}