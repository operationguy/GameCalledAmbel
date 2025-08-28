if (sprite_index != -1){draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);}

draw_set_halign(align);

var _dy = 0;

if (title != ""){
	draw_set_font(fnt_big);
	draw_text_color(x+cx,y+cy+_dy,title,color_t,color_t,color_t,color_t,1);
	_dy += 10;
}

if (desc != ""){
	draw_set_font(fnt_def);
	draw_text_color(x+cx,y+cy+_dy,desc,color_d,color_d,color_d,color_d,1);
}

draw_set_font(fnt_def);
draw_set_halign(fa_left);