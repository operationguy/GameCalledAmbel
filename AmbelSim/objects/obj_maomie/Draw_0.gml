var _wave = wave(pv, 1);
if held{shader_set(sh_negative)}

var _breathe = 0.05*abs(sin(4*degtorad(local_timer)+pv));

if selected{
	draw_sprite_ext(spr_pawn_ring,0,x,y,0.1*_wave+1,0.1*_wave+0.4,0,c_white,1);
}

draw_sprite_ext(sprite_index,image_index,x,y,z.zoom*image_xscale,z.zoom+_breathe,0,c_white,1);

shader_reset();