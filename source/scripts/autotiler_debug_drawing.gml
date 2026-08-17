/*key=ds_map_find_first(autotiler_tree) repeat (ds_map_size(autotiler_tree)) {
    string_token_start(key,"_")
    xx=string_token_real()
    yy=string_token_real()

    grid=ds_map_find_value(autotiler_tree,key)

    draw_rectangle(xx,yy,xx+autotiler_tree_size*gridx,yy+autotiler_tree_size*gridy,1)

    u=0 repeat (autotiler_tree_size) {v=0 repeat (autotiler_tree_size) {
        if (ds_grid_get(grid,u,v)) draw_rect(xx+u*gridx+gridox,yy+v*gridy+gridoy,gridx,gridy,$ff)
    v+=1}u+=1}
key=ds_map_find_next(autotiler_tree,key)}
