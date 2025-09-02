if global.assigning{on_click(assign_task_to_selected(new TaskObj("forage",1,
	// exec
	function(){
		body.damage(1);
		if body.hp == 0{
			done = true;
		}
	},
	// finish
	function(){
		create_item(ITEM.MUSHROOM);
	},
"Picking Mushroom")));}

else{
	held = false;
}

depth = base_depth - y;