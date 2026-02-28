if (keyboard_check_pressed(vk_escape)) {
    instance_activate_all(); // Bring everything back to life
    instance_destroy();      // Remove the menu
}