
var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);

var _lay_id = layer_get_id("Tiles_1");
var _map_id = layer_tilemap_get_id(_lay_id);


h_speed = (_right - _left) * walk_speed;


if (tilemap_get_at_pixel(_map_id, x + h_speed, bbox_top) || 
    tilemap_get_at_pixel(_map_id, x + h_speed, bbox_bottom)) {
    while (!tilemap_get_at_pixel(_map_id, x + sign(h_speed), bbox_top) && 
           !tilemap_get_at_pixel(_map_id, x + sign(h_speed), bbox_bottom)) {
        x += sign(h_speed);
    }
    h_speed = 0;
}
x += h_speed;


v_speed += gravity_power;


if (tilemap_get_at_pixel(_map_id, bbox_left, y + v_speed) || 
    tilemap_get_at_pixel(_map_id, bbox_right, y + v_speed)) {
    while (!tilemap_get_at_pixel(_map_id, bbox_left, y + sign(v_speed)) && 
           !tilemap_get_at_pixel(_map_id, bbox_right, y + sign(v_speed))) {
        y += sign(v_speed);
    }
    

    if (v_speed > 0) on_ground = true;
    v_speed = 0;
} else {
    on_ground = false;
}

if (on_ground && _jump) {
    v_speed = jump_power;
    on_ground = false;
}
y += v_speed;


if (!on_ground) {

    if (v_speed < 0) sprite_index = Jump;
    else             sprite_index = Fall;
} else {

    if (h_speed != 0) {
        sprite_index = Run;
    } else {
        sprite_index = Idle;
    }
}


if (h_speed != 0) image_xscale = sign(h_speed);