global.names = load_json("names.json");
global.quirks = load_json("quirks.json");
global.paused = false;
global.reading = false;
global.assigning = false;

global.temperature = 20;
global.precipitation = 0;
global.light = 0;

draw_set_font(fnt_def);