state = "MOVE"; // Initial state

walk_speed = 5;
h_speed = 0;
v_speed = 0;

gravity_power = 0.5;
jump_power = -9; 

on_ground = false;

my_scale = 2;
image_xscale = my_scale;
image_yscale = my_scale;

is_attacking = false;
attack_sprite = Attack_1;  
attack_speed = 1; 

//Dash system

is_dashing = false;

dash_power = 24;
dash_friction = 0.85; 
dash_velocity = 0;

dash_time = 14;
dash_timer = 0;

dash_cooldown = 20;  
dash_cooldown_timer = 0;

dash_sprite = Dash;    