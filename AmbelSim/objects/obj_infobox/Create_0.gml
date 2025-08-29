image_xscale = width/240;
image_yscale = height/240;

elems = array_concat(elems, [
	instance_create_depth(width-40,y+40,depth-1,obj_button,
	{
		image_index : 9,
		parent : self.id,
		ignore_read : true,
		func : function(_p){
			global.reading = false;
			global.paused = parent.pause;
			instance_destroy(parent);
		}
	})
]);

global.paused = true;