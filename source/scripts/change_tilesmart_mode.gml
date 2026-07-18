if (tilebgpal!=noone) {
    if (bg_tilemode[tilebgpal]!=-argument0 and bg_tilemode[tilebgpal]!=0) {
        if (ds_grid_get_max(bg_tilemap[tilebgpal],0,0,46,1)!=noone)
            if (!show_question("This tileset already has data for "+pick(bg_tilemode[tilebgpal]-1,"2","4","9","16","47")+"-tile mode.##Are you sure you want to change the type? This will discard the current smart tiler data."))
                exit
    }

    bg_tilemode[tilebgpal]=argument0
    ds_grid_set_region(bg_tilemap[tilebgpal],0,0,46,1,noone)
    tilemap_complete=0
    atcx=0
    atcy=0
}
