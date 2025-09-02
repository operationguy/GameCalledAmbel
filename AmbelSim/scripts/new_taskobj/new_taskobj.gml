function TaskObj(_skill,_tick,_func = function(){},_finish = function(){return noone;},_title = "Doing Unknown Task",_inst = noone) constructor{
	title = _title;
	func = _func;
	skill = _skill;
	base_tick = _tick;
	inst = _inst;
	finish = _finish;
	done = false;
	
	static set_inst = function(_inst){
		inst = _inst;
	}
	
	static get_inst = function(){
		return inst;
	}
	
	static tick_num = function(){
		return round(base_tick*(14-skill.level/12));
	}
	
	static execute_task = function(){
		func();
		inst.mind[$ skill].add_exp(1);
	}
	
	static finish_action = function(){
		return finish();
	}
}

function MoveTaskObj(_path, _x, _y, _task) constructor{
	path = _path;
	px = _x;
	py = _y;
	task = _task;
	
	static set_inst = function(_inst){
		task.inst = _inst;
	}
	
	static get_inst = function(){
		return task.inst;
	}
	
	static tick_num = function(){
		return task.tick_num();
	}
	
	static execute_task = function(){
		var _inst = task.inst;
		if (_inst.x == px && _inst.y == py){
			task.execute_task();
		}
		else with _inst{
			if (path_get_point_x(other.path,1) != other.px || path_get_point_y(other.path,1) != py){
				other.path(self.id,other.px,other.py)
			}
		}
	}
	
	static finish_action = function(){
		return task.finish_action();
	}
}