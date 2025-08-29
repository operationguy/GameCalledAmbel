randomize();
edit_mode = false;
global.ambel_name = generate_random_ambel_name();

function start_sim(){
	while (array_length(elems) > 0){
		instance_destroy(array_pop(elems));
	}
	
	instance_create_layer(room_width-30,room_height-30,"UI",obj_button,{
		image_index : global.paused ? 10 : 11,
		func : function(_p){
			global.paused = !global.paused;
			image_index = global.paused ? 10 : 11;
		}
	});
	
	// make starting maomie
	repeat(3){
		instance_create_layer(random_range(120,room_width-120),random_range(120,room_height-120),"Objects",obj_maomie,
		{image_index : irandom(17), ambel : global.ambel_name}
		);
	}
	
	// generate map
	for (var _x = 20; _x <= room_width-20; _x += 40){
		for (var _y = 60; _y <= room_height-20; _y += 40){
			if (irandom(4) == 0){
				instance_create_layer(_x+irandom_range(-10,10),_y+irandom_range(-10,10),"Objects",obj_tree);
			}
			else if (irandom(10) == 0){
				instance_create_layer(_x+irandom_range(-10,10),_y+irandom_range(-10,10),"Objects",obj_bush);
			}
			else if (irandom(12) == 0){
				instance_create_layer(_x+irandom_range(-10,10),_y+irandom_range(-10,10),"Objects",obj_mushroom);
			}
		}
	}
	
	layer_background_blend(layer_background_get_id("Background"),#296A6A);
	
	instance_destroy(self.id);
}

elems = [
	instance_create_layer(x-156,y+108,"UI",obj_button,{
		image_index : 8,
		parent : self.id,
		func : function(_p){
			with parent{
				global.ambel_name = generate_random_ambel_name();
		}}
	}),
	instance_create_layer(x-120,y+108,"UI",obj_button,{
		image_index : 6,
		parent : self.id,
		func : function(_p){
			with parent{
				edit_mode = !edit_mode;
		}},
		toggle : true
	}),
	instance_create_layer(x,y+2*room_height/5,"UI",obj_button,{
		sprite_index : spr_next,
		parent : self.id,
		func : function(_p){
			with parent{
				start_sim();
		}}
	})
]