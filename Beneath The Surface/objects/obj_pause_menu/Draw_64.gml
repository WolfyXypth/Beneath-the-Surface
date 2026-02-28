// Draw a semi-transparent background
draw_set_alpha(0.5);
draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Draw your menu text/buttons
draw_text(100, 100, "PAUSED - Press ESC to Resume");