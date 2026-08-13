key=ds_map_find_first(autotiler_tree) repeat (ds_map_size(autotiler_tree)) {
    string_token_start(key,"_")
    xx=real(string_token_next())
    yy=real(string_token_next())

    grid=ds_map_find_value(autotiler_tree,key)

    draw_rectangle(xx,yy,xx+autotiler_tree_size*gridx,yy+autotiler_tree_size*gridy,1)

    u=0 repeat (autotiler_tree_size) {v=0 repeat (autotiler_tree_size) {
        if (ds_grid_get(grid,u,v)) draw_rect(xx+u*gridx,yy+v*gridy,gridx,gridy,$ff)
    v+=1}u+=1}
key=ds_map_find_next(autotiler_tree,key)}
