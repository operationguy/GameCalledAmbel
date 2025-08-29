if (sprite_index == -1){exit;}

draw_sprite_ext(sprite_index,image_index,x,y,z.zoom*image_xscale,z.zoom,0,c_white,0.3);
draw_text(x+sprite_width/2,y+sprite_width/2,(stack > 1) ? string(stack) : "");