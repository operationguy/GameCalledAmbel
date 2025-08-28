function generate_random_ambel_name(){
	var _a = global.names.ambel_first;
	var _b = global.names.ambel_second;
	
	var _ra = _a[irandom(array_length(_a)-1)];
	var _rb = _b[irandom(array_length(_b)-1)];
	
	if string_char_at(_ra,string_length(_ra)) == string_char_at(_rb,1){_rb = string_delete(_rb,1,1);}
	
	return string_concat(_ra,_rb);
}