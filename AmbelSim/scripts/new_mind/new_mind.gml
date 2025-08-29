function MindPart(_lev = 0, _exp = 0, _int = false, _name = "") constructor{
	static lev_thresholds = [30,60,90,120,240,360,480,600,1200,2400,infinity];
	
	name = _name;
	level = _lev;
	experience = _exp;
	interest = _int;
	to_next_level = lev_thresholds[_lev];
	subparts = {};
	
	static level_up = function(){
		level++;
		if (level >= 10){level = 10;}
		experience = 0;
		to_next_level = lev_thresholds[level];
	}
	
	static add_exp = function(_e){
		experience += round(_e*(1+interest*0.5));
		if (_e >= to_next_level){
			level_up();
		}
	}
	
	static tick_forget = function(){
		experience = clamp(experience-interest,0,to_next_level);
	}
	
	static insert_subpart = function(_key,_part){
		subparts[$ _key] = _part;
		_part.name = _key;
	}
	
	static clear = function(){
		level = 0;
		experience = 0;
		to_next_level = lev_thresholds[0];
		interest = false;
	}
	
	static scramble = function(){
		var _i = struct_get_names(subparts);
		while (array_length(_i) > 0){
			var _sp = subparts[$ array_pop(_i)];
			_sp.clear();
			repeat(irandom(4)){
				_sp.level_up();
			}
			_sp.interest = irandom(5) == 0 ? true : false;
		}
	}
}

function new_mind(){
	var _r = new MindPart(0,0,false,"whole mind");
	
	_r.insert_subpart("forage",new MindPart());
	_r.insert_subpart("combat",new MindPart());
	_r.insert_subpart("social",new MindPart());
	_r.insert_subpart("design",new MindPart());
	
	return _r;
}