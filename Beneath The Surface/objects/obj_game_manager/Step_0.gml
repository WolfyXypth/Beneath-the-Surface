// In Create Event of obj_game_manager
excluded_rooms = [victory, death_menu, rm_menu, cutscene];

// In Step Event
var _is_excluded = false;
for (var i = 0; i < array_length(excluded_rooms); i++) {
    if (room == excluded_rooms[i]) {
        _is_excluded = true;
        break;
    }
}

if (!_is_excluded && keyboard_check_pressed(vk_escape)) {
    if (!instance_exists(obj_pause_menu)) {
        instance_deactivate_all(true);
        instance_create_layer(0, 0, "Instances_1", obj_pause_menu);
    } else {
        instance_activate_all();
        instance_destroy(obj_pause_menu);
    }
}