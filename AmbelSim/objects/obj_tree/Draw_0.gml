if held{shader_set(sh_negative)}

draw_sprite_ext(sprite_index,image_index,x,y,z.zoom*image_xscale,z.zoom,0,c_white,1);

shader_reset();