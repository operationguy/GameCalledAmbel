function Movement(_path,_inst,_manual = false) constructor{
	path = _path;
	manual = _manual;
	inst = _inst;
	
	static activate = function(){
		path(inst);
	}
}