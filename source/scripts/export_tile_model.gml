var unique_bgs,key,model,bg,bgw,bgh,vc,l,t,w,h;

unique_bgs=dsmap()

instance_activate_object(tileholder)

with (tileholder) {
    myname=bgname+"_"+string(tile_get_depth(tile))
    if (!ds_map_exists(unique_bgs,myname)) ds_map_add(unique_bgs,myname,bgname)
}

key=ds_map_find_first(unique_bgs) repeat (ds_map_size(unique_bgs)) {
    model=d3d_model_create()
    bg=bg_background[ds_list_find_index(backgrounds,dsmap(unique_bgs,key))]
    bgw=background_get_width(bg)
    bgh=background_get_height(bg)
    d3d_model_primitive_begin(model,pr_trianglelist)
    vc=0
    with (tileholder) if (myname==key) {
        l=tile_get_left(tile)
        t=tile_get_top(tile)
        w=tile_get_width(tile)
        h=tile_get_height(tile)
        d3d_model_vertex_texture(model,x,y,depth,l/bgw,t/bgh)
        d3d_model_vertex_texture(model,x+w*tilesx,y,depth,(l+w)/bgw,t/bgh)
        d3d_model_vertex_texture(model,x,y+h*tilesy,depth,l/bgw,(t+h)/bgh)
        d3d_model_vertex_texture(model,x,y+h*tilesy,depth,l/bgw,(t+h)/bgh)
        d3d_model_vertex_texture(model,x+w*tilesx,y,depth,(l+w)/bgw,t/bgh)
        d3d_model_vertex_texture(model,x+w*tilesx,y+h*tilesy,depth,(l+w)/bgw,(t+h)/bgh)
        vc+=6
        if (vc>=16000) {
            d3d_model_primitive_end(model)
            d3d_model_primitive_begin(model,pr_trianglelist)
            vc=0
        }
    }
    d3d_model_primitive_end(model)
    d3d_model_bake(model)
    d3d_model_save(model,root+key+".g3d")
    d3d_model_save_g3z(model,root+key+".g3z")
    d3d_model_destroy(model)
key=ds_map_find_next(unique_bgs,key)}

ds_map_destroy(unique_bgs)

change_mode(mode)
