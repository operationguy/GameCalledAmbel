if held || toggled{
	shader_set(sh_negative)
}

draw_sprite_ext(sprite_index,image_index,x,y,z.zoom,z.zoom,0,c_white,1);

shader_reset();