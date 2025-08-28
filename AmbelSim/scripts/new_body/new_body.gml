function BodyPart(_hpmax, _healmod, _vital = false, _name = "") constructor{
	name = _name
	hpmax = _hpmax;
	hp = _hpmax;
	healmod = _healmod
	vital = _vital
	conditions = {}
	subparts = {}
	
	static tick_heal = function(){
		var _mod = clamp(healmod*(hp+0.2),0,1);
		
		hp = (hp <= 0) ? 0 : clamp(hp+0.1*_mod,0,1);
		
		if (vital && hp <= 0){
			/*trigger death*/
		}
	}
	
	static damage = function(_dmg){
		hp = clamp(hp-_dmg,0,1);
	}
	
	static add_condition = function(_key,_val){
		conditions[$ _key] = _val;
	}
	
	static insert_subpart = function(_key,_part){
		subparts[$ _key] = _part;
		_part.name = _key;
	}
	
	static hp_to_string = function(){
		return string_concat(hp,"/",hpmax);
	}
	
	static name_to_string = function(){
		return name;
	}
}

function new_body(){
	var _r = new BodyPart(1,true,false,"whole body");
	_r.insert_subpart("head", new BodyPart(1,0.8,true));
	_r.subparts[$ "head"].insert_subpart("brain", new BodyPart(1,0,true));
	_r.subparts[$ "head"].insert_subpart("eye_l", new BodyPart(1,0));
	_r.subparts[$ "head"].insert_subpart("eye_r", new BodyPart(1,0));
	
	_r.insert_subpart("torso", new BodyPart(1,1,true));
	_r.subparts[$ "torso"].insert_subpart("heart", new BodyPart(1,0.4,true));
	_r.subparts[$ "torso"].insert_subpart("lungs", new BodyPart(1,0.3,true));
	_r.subparts[$ "torso"].insert_subpart("liver", new BodyPart(1,0.3,true));
	_r.subparts[$ "torso"].insert_subpart("guts", new BodyPart(1,0.5,true));
	
	_r.insert_subpart("arm_l", new BodyPart(1,0.7));
	_r.subparts[$ "arm_l"].insert_subpart("paw", new BodyPart(1,0.7));
	
	_r.insert_subpart("arm_r", new BodyPart(1,0.7));
	_r.subparts[$ "arm_r"].insert_subpart("paw", new BodyPart(1,0.7));
	
	_r.insert_subpart("leg_l", new BodyPart(1,0.5));
	_r.subparts[$ "leg_l"].insert_subpart("foot", new BodyPart(1,0.5));
	
	_r.insert_subpart("leg_r", new BodyPart(1,0.5));
	_r.subparts[$ "leg_r"].insert_subpart("foot", new BodyPart(1,0.5));
	
	_r.insert_subpart("tail", new BodyPart(1,0.1));
	
	return _r;
}