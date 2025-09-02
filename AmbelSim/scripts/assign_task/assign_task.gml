function assign_task_to_selected(_task){
	with obj_maomie{
		if (selected && ambel == global.ambel_name){
			_task.set_inst(self.id);
			schedule_task(_task);
			return;
		}
	}
}