draw_sprite_ext(sprite_index,image_index,x,y,z.zoom*image_xscale,z.zoom,0,c_white,0.3);

if hover{
	draw_set_halign(fa_center);
	draw_text(x,y-50,name)
	draw_set_halign(fa_left);
}