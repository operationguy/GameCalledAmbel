z = {
	ac : 0,
	zoom : 1,
	base : 1
}

hover = false
toggle = false;
toggled = false;
held = false;

image_xscale = z.base;
image_yscale = z.base;

image_index = irandom(image_number-1);

if irandom(1){image_xscale = -1;}

base_depth = depth;

body = new BodyPart(1,0,true,"obj");