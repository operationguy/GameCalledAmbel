enum QUIRK{
	EMPTY = -1,
	TASK_QUEUE = -2,
	TASK_STACK = -3,
	TASK_RANDOM = -4,
	FAST = 0,
	SLOW = 1,
	GROUCH = 2,
	OPTIMIST = 3,
	CALORIES = 4,
	LEARNER = 5,
	RUGGED = 6,
	ADAMANT = 7,
	PACIFIST = 8
}

function SoulPart(_quirk, _func = function(_p){}, _per = 60) constructor{
	static colors = [ #FFFFFF, #FF0000, #FFFF00, #00FF00, #00FFFF, #0000FF, #FF00FF ];
	
	var _q = global.quirks[$ string(_quirk)];
	
	title = _q.title;
	desc = _q.desc;
	excl = struct_exists(_q, "excl") ? _q[$ "excl"] : [];
	col = struct_exists(_q, "col") ? colors[_q[$ "col"]] : colors[0];
	qid = _quirk;
	period = _per;
	func = _func;
	subparts = {};
	
	static has_quirk = function(_key){
		var _k = is_string(_key) ? _key : string(_key);
		return struct_exists(subparts, _k);
	}
	
	static tick = function(_t, _params = {}){
		if (_t%_per == 0){func(_params);}
	}
	
	static insert_subpart = function(_key,_part){
		subparts[$ _key] = _part;
		_part.name = _key;
	}
	
	static quirkify = function(_n){
		var _size = array_length(struct_get_names(global.quirks))-5;
		repeat(_n){
			var _i = irandom(_size);
			var _qs = struct_get_names(subparts);
			while (array_length(_qs) > 0){
				var _q = subparts[$ array_pop(_qs)];
				if array_contains(_q.excl, _i){
					struct_remove(subparts, _q);
				}
			}
			insert_subpart(string(_i),new SoulPart(_i));
		}
	}
}

function new_soul(){
	var _r = new SoulPart(-1);
	
	_r.insert_subpart("task",new SoulPart(irandom_range(-2,-4)));
	
	return _r;
}