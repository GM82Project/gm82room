if (!hide3dgizmo) {
    d3d_set_lighting(1)
    d3d_set_culling(1)
    d3d_light_define_direction(0,1,1,-1,$ffffff)
    d3d_light_enable(0,1)
    d3d_light_define_ambient($606060)
    d3d_transform_add_rotation_x(90)
    d3d_transform_add_rotation_y(-90)
    d3d_transform_xyt(-knobx,-knoby,width-48-160,48+32,0)
        d3d_draw_ellipsoid(-32,-32,-32,32,32,32,knobtex,1,-1,16)
    d3d_transform_set_identity()
    d3d_set_lighting(0)
    d3d_set_culling(0)
}
