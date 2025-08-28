enum QUIRK{
	EMPTY = -1,
	TASK_QUEUE = -2,
	TASK_STACK = -3,
	TASK_RANDOM = -4
}

function SoulPart(_quirk, _func = function(_p){}, _per = 60) constructor{
	var _q = global.quirks[$ string(_quirk)];
	
	title = _q.title;
	desc = _q.desc;
	qid = _quirk;
	period = _per;
	func = _func;
	subparts = {};
	
	static has_quirk = function(_key){
		return struct_exists(subparts, _key);
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
			insert_subpart(string(_n),irandom(_size));
		}
	}
}

function new_soul(){
	var _r = new SoulPart(-1);
	
	_r.insert_subpart("task",new SoulPart(irandom_range(-2,-4)));
	
	return _r;
}