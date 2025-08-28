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

local_timer = 0;
pv = irandom(99);

food = 1;
heat = 1;
mood = 1;
rest = 1;
stress = 0;

equip = empty_item();
carry = empty_item();

body = new_body();
mind = new_mind();
soul = new_soul();

mind.scramble();

path = path_add();
path_set_closed(path,false);

function local_tick(_p){
	return (local_timer+pv)%_p == 0;
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
			perc_disp(78,84,"STRESS",stress,true),
			
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
			
			std_disp(200,344,"THEORY",mind.subparts[$ "theory"].level,mind.subparts[$ "theory"].interest ? #00FF00 : #C6C6C6),
			std_disp(220,356,"exp",mind.subparts[$ "theory"].experience),
			std_disp(220,368,"next",mind.subparts[$ "theory"].to_next_level),
		)
	});
	
	if !is_empty_item(equip){
		array_push(_i.elems,instance_create_layer(40,128,"InfoboxText",obj_button,{
			image_index : 4,
			parent : self.id,
			func : function(_p){
			}
		}));
	}
	
	if !is_empty_item(carry){
		array_push(_i.elems,instance_create_layer(40,168,"InfoboxText",obj_button,{
			image_index : 4,
			parent : self.id,
			func : function(_p){
			}
		}));
	}
	
	global.paused = true;
}