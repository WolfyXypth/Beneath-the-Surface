if (!is_dashing && dash_cooldown_timer <= 0 && keyboard_check_pressed(vk_shift)) {

    is_dashing = true;
    dash_timer = dash_time;

    var dash_direction = sign(image_xscale);
    dash_velocity = dash_direction * dash_power;
}

if (dash_cooldown_timer > 0) {
    dash_cooldown_timer--;
}

// ATTACK INPUT
if (!is_attacking && keyboard_check_pressed(ord("Q"))) {
    is_attacking = true;
    sprite_index = attack_sprite;
    image_index = 0;
    image_speed = attack_speed;
}

// STOP MOVEMENT DURING ATTACK
if (is_attacking) {
    h_speed = 0;
}

// 1. INPUTS
var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);

// 2. TILEMAP SETUP
var _lay_id = layer_get_id("Tiles_1");
var _map_id = layer_tilemap_get_id(_lay_id);


// 3. HORIZONTAL MOVEMENT
h_speed = (_right - _left) * walk_speed;

// DASH MOVEMENT
if (is_dashing) {

    h_speed = dash_velocity;

    dash_velocity *= dash_friction; 

    dash_timer--;
	
	v_speed *= 0.9;

    if (dash_timer <= 0) {
        is_dashing = false;
    }
}

if (tilemap_get_at_pixel(_map_id, x + h_speed, bbox_top) || 
    tilemap_get_at_pixel(_map_id, x + h_speed, bbox_bottom - 4)) { 
    
    while (!tilemap_get_at_pixel(_map_id, x + sign(h_speed), bbox_top) && 
           !tilemap_get_at_pixel(_map_id, x + sign(h_speed), bbox_bottom - 4)) {
        x += sign(h_speed);
    }
    h_speed = 0;
}
x += h_speed;

// 4. VERTICAL MOVEMENT (GRAVITY)
v_speed += gravity_power;


var _collide_v = tilemap_get_at_pixel(_map_id, bbox_left, y + v_speed) || 
                 tilemap_get_at_pixel(_map_id, bbox_right, y + v_speed) ||
                 tilemap_get_at_pixel(_map_id, x, y + v_speed);

if (_collide_v) {
    while (!tilemap_get_at_pixel(_map_id, bbox_left, y + sign(v_speed)) && 
           !tilemap_get_at_pixel(_map_id, bbox_right, y + sign(v_speed)) &&
           !tilemap_get_at_pixel(_map_id, x, y + sign(v_speed))) {
        y += sign(v_speed);
    }
    
    if (v_speed > 0) on_ground = true;
    v_speed = 0;
} else {
    on_ground = false;
}

// JUMPING
if (on_ground && _jump) {
    v_speed = jump_power;
    on_ground = false;
}
y += v_speed;

// 5. ANIMATIONS

if (is_dashing) {
    sprite_index = dash_sprite;
}
else if (is_attacking) {
    if (image_index >= image_number - 1) {
        is_attacking = false;
    }
}
else {
    if (!on_ground) {
        if (v_speed < 0) sprite_index = Jump;
        else             sprite_index = Fall;
    } 
    else {
        if (h_speed != 0) sprite_index = Run;
        else              sprite_index = Idle;
    }
}

// 6. FLIPPING (Corrected for your scale)
if (h_speed != 0) {
    image_xscale = sign(h_speed) * my_scale;
}

