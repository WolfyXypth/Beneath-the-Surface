if (instance_exists(target)) {

    var cam = view_camera[0];

    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);

    var target_x = target.x - camera_get_view_width(cam) / 2;
    var target_y = target.y - camera_get_view_height(cam) / 2;

    // Smooth interpolation
    cam_x = lerp(cam_x, target_x, follow_speed);
    cam_y = lerp(cam_y, target_y, follow_speed);

    camera_set_view_pos(cam, cam_x, cam_y);
}