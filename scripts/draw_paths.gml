if (view[7]) {
    texture_set_interpolation(0)
    texture_set_repeat(1)
    for (i=0;i<pathnum;i+=1) {
        d3d_model_draw(paths[i,3],0,0,0,-1)
    }
    texture_set_interpolation(interpolation)
}
