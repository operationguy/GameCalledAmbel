z = {
	ac : 0,
	zoom : 1,
	base : 1
}

base_depth = depth;

hover = false
toggle = true;
toggled = false;
held = false;

image_xscale = z.base;
image_yscale = z.base;

// PAWN EXCLUSIVES //

selected = false;

local_timer = 0;
pv = irandom(99);

food = 1;
heat = 1;
mood = 1;
rest = 1;
stress = 0;
pain = 0;

equip = empty_item();
carry = empty_item();

movelist = [];
tasklist = [];
task = {};

body = new_body();
mind = new_mind();
soul = new_soul();

mind.scramble();
soul.quirkify(irandom(1));

p_spd = 1;
set_speed();

path = path_add();
path_set_closed(path,false);
path_position = 1;

function select(){
	with obj_maomie{
		if (self.id != other.id){selected = false;}
		else {selected = !selected}
	}
	global.assigning = selected;
}

function local_tick(_p){
	return (local_timer+pv)%_p == 0;
}

function schedule_task(_t, _period = 1){
	if local_tick(_period){
		if soul.has_quirk(QUIRK.TASK_QUEUE){
			array_insert(tasklist,0,_t);
		}
		else if soul.has_quirk(QUIRK.TASK_STACK){
			array_push(tasklist,_t);
		}
		else{
			array_insert(tasklist,irandom(array_length(tasklist)),_t);
		}
	}
}

function enqueue_movement(_m){
	if _m.manual{
		array_foreach(movelist,function(_elem,_ind){
			if _elem.manual{
				array_delete(movelist,_ind,1);
			}
		});
		array_insert(movelist,0,_m);
	}
	
	else{
		array_push(movelist,_m);
	}
}

function dequeue_movement(){
	if (array_length(movelist) == 0){return false;}
	
	array_shift(movelist).activate();
	return true;
}

function perform_task(){
	// check to see if task is not a Task Object
	if !is_instanceof(task,TaskObj){
		// get the next task in queue
		if !(array_length(tasklist) == 0){
			next_task();
		}
		else return;
	}
	// tick task
	if local_tick(task.tick_num()){
		task.execute_task();
	}
	// check if task is finished
	if task.done{
		task = finish_action();
	}
}

function next_task(){
	if (array_length(tasklist) == 0){
		task = noone;
	}
	else{
		task = array_pop(tasklist);
	}
}

function no_tasks_or_movement(){
	return (struct_names_count(task) == 0 && array_length(tasklist) == 0 && array_length(movelist) == 0);
}

function set_speed(_spd = 1){
	// quirk modifier
	var _qs = 1;
	
	if soul.has_quirk(QUIRK.FAST){
		_qs = 1.5;
	}
	else if soul.has_quirk(QUIRK.SLOW){
		_qs = 0.75;
	}
	
	// body damage modifier
	var _bs = 
	0.5 * (body.get_part("leg_l").get_part("foot").hp + body.get_part("leg_l").hp)/2
	+
	0.5 * (body.get_part("leg_r").get_part("foot").hp + body.get_part("leg_r").hp)/2
	;
	
	// pain modifier
	var _ps = 1-pain;
	
	p_spd = _spd * _qs * _bs * _ps;
}

function perc_tick(_var,_p,_x){
	return local_tick(_p) ? clamp(_var+_x,0,1) : _var;
}

function perc_tostring(_f){
	return string_concat(round(_f*100),"%");
}

function perc_tocolor(_f, _base, _i = false){
	var _r = _base;
	if ((!_i && _f <= 0.75) || (_i && _f >= 0.25)){_r = #FFFF00;}
	if ((!_i && _f <= 0.5) || (_i && _f >= 0.5)){_r = #FF8800;}
	if ((!_i && _f <= 0.25) || (_i && _f >= 0.75)){_r = #FF0000;}
	if ((!_i && _f == 0) || (_i && _f >= 1)){_r = #880000;}
	return _r;
}

function perc_disp(_x,_y,_title,_val,_i = false){
	return [
		caption(_x,_y,,,_title,#FFFFFF), 
		caption(_x+90,_y,,,perc_tostring(_val),perc_tocolor(_val,#C6C6C6,_i),fa_right)
	];
}

function std_disp(_x,_y,_title,_val,_col = #C6C6C6){
	return [
		caption(_x,_y,,,_title,#FFFFFF),
		caption(_x+90,_y,,,string(_val),_col,fa_right)
	];
}

func_l = function(_q){
	select();
}

func_r = function(_p){
	global.reading = true;
	
	var _i = instance_create_layer(0,0,"Infobox",obj_infobox,{
		pause : global.paused,
		name : self.name,
		elems : array_concat(
		//essentials
			perc_disp(28,60,"FOOD",food),
			perc_disp(128,60,"HEAT",heat),
			perc_disp(28,72,"MOOD",mood),
			perc_disp(128,72,"REST",rest),
			perc_disp(28,84,"STRESS",stress,true),
			perc_disp(128,84,"PAIN",pain,true),
			
		//items
			[
			caption(60,120,,,"EQUIPPED",#FFFFFF),
			obj(168,120,{
				sprite_index : equip.sprite_index,
				image_index : equip.image_index,
				desc : equip.title,
				color_d : #FFFFFF,
				cx : equip.sprite_width
			}),
			caption(60,160,,,"CARRYING",#FFFFFF),
			obj(168,160,{
				sprite_index : carry.sprite_index,
				image_index : carry.image_index,
				desc : carry.title,
				color_d : #FFFFFF,
				cx : carry.sprite_width
			})
			],
			
		//body
			perc_disp(28,200,"HEAD",body.subparts[$ "head"].hp),
			perc_disp(48,212,"Brain",body.subparts[$ "head"].subparts[$ "brain"].hp),
			perc_disp(48,224,"Eye (L)",body.subparts[$ "head"].subparts[$ "eye_l"].hp),
			perc_disp(48,236,"Eye (R)",body.subparts[$ "head"].subparts[$ "eye_r"].hp),
			
			perc_disp(28,260,"TORSO",body.subparts[$ "torso"].hp),
			perc_disp(48,272,"Heart",body.subparts[$ "torso"].subparts[$ "heart"].hp),
			perc_disp(48,284,"Lungs",body.subparts[$ "torso"].subparts[$ "lungs"].hp),
			perc_disp(48,296,"Liver",body.subparts[$ "torso"].subparts[$ "liver"].hp),
			perc_disp(48,308,"Guts",body.subparts[$ "torso"].subparts[$ "guts"].hp),
			
			perc_disp(28,332,"ARM (L)",body.subparts[$ "arm_l"].hp),
			perc_disp(48,344,"Paw (L)",body.subparts[$ "arm_l"].subparts[$ "paw"].hp),
			
			perc_disp(28,368,"ARM (R)",body.subparts[$ "arm_r"].hp),
			perc_disp(48,380,"Paw (R)",body.subparts[$ "arm_r"].subparts[$ "paw"].hp),
			
			perc_disp(28,404,"LEG (L)",body.subparts[$ "leg_l"].hp),
			perc_disp(48,416,"Foot (L)",body.subparts[$ "leg_l"].subparts[$ "foot"].hp),
			
			perc_disp(28,440,"LEG (R)",body.subparts[$ "leg_r"].hp),
			perc_disp(48,452,"Foot (R)",body.subparts[$ "leg_r"].subparts[$ "foot"].hp),
			
			perc_disp(28,476,"TAIL",body.subparts[$ "tail"].hp),
			
		//mind
			std_disp(200,200,"FORAGE",mind.subparts[$ "forage"].level,mind.subparts[$ "forage"].interest ? #00FF00 : #C6C6C6),
			std_disp(220,212,"exp",mind.subparts[$ "forage"].experience),
			std_disp(220,224,"next",mind.subparts[$ "forage"].to_next_level),
			
			std_disp(200,248,"COMBAT",mind.subparts[$ "combat"].level,mind.subparts[$ "combat"].interest ? #00FF00 : #C6C6C6),
			std_disp(220,260,"exp",mind.subparts[$ "combat"].experience),
			std_disp(220,272,"next",mind.subparts[$ "combat"].to_next_level),
			
			std_disp(200,296,"SOCIAL",mind.subparts[$ "social"].level,mind.subparts[$ "social"].interest ? #00FF00 : #C6C6C6),
			std_disp(220,308,"exp",mind.subparts[$ "social"].experience),
			std_disp(220,320,"next",mind.subparts[$ "social"].to_next_level),
			
			std_disp(200,344,"DESIGN",mind.subparts[$ "design"].level,mind.subparts[$ "design"].interest ? #00FF00 : #C6C6C6),
			std_disp(220,356,"exp",mind.subparts[$ "design"].experience),
			std_disp(220,368,"next",mind.subparts[$ "design"].to_next_level),
		)
	});
	
	var _quirks = struct_get_names(soul.subparts);
	var _dy = 0;
	while (array_length(_quirks) > 0){
		var _q = soul.subparts[$ array_pop(_quirks)];
		array_push(_i.elems,caption(200,392+_dy,,,_q.title,_q.col));
		array_push(_i.elems,caption(220,404+_dy,,,_q.desc,#C6C6C6));
		_dy += 24;
	}
	
	if !is_empty_item(equip){
		array_push(_i.elems,instance_create_layer(40,128,"InfoboxText",obj_button,{
			image_index : 4,
			parent : self.id,
			func : function(_p){
			},
			ignore_read : true,
		}));
	}
	
	if !is_empty_item(carry){
		array_push(_i.elems,instance_create_layer(40,168,"InfoboxText",obj_button,{
			image_index : 4,
			parent : self.id,
			func : function(_p){
			},
			ignore_read : true,
		}));
	}
}