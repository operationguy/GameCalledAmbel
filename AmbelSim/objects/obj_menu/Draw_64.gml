draw_self();

draw_set_halign(fa_center);
draw_text(x,y-60,"A GAME CALLED");

draw_set_halign(fa_left);
draw_set_font(fnt_big);
draw_text(x-100,y+93,string_concat("[AMBEL NAME]:  ", ambel_name));
draw_set_font(fnt_def);
