function load_json(_filename){
	var _f = file_text_open_read(_filename);
	
	var _r = "";
	while !file_text_eof(_f){
		_r = string_concat(_r,file_text_read_string(_f));
		file_text_readln(_f);
	}
	
	file_text_close(_f);
	return json_parse(_r);
}