function TaskObj(_skill,_tick,_func = function(){},_title = "Doing Unknown Task") constructor{
	title = _title;
	func = _func;
	skill = _skill;
	base_tick = _tick;
	done = false;
	
	static tick_num = function(){
		return round(base_tick*(14-skill.level/12));
	}
	
	static execute_task = function(){
		func();
		inst.mind[$ skill].add_exp(1);
	}
	
	static finish_action = function(){
		return noone;
	}
}