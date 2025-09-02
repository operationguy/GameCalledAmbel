function wave(_pv = 0,_f = 0.5){
	return sin(_pv + get_timer()/(_f * 100000));
}