if (tilebgpal!=noone) {
    if (bg_tilemode[tilebgpal]!=-argument0 and bg_tilemode[tilebgpal]!=0 and bg_tilemode[tilebgpal]!=7 and bg_tilemode[tilebgpal]!=8) {
        if (ds_grid_get_max(bg_tilemap[tilebgpal],0,0,46,1)!=noone)
            if (!show_question("This tileset already has data for "+tile_mode_name(bg_tilemode[tilebgpal])+" mode.##Are you sure you want to change the type? This will discard the current data."))
                exit
    }

    bg_tilemode[tilebgpal]=argument0
    ds_grid_set_region(bg_tilemap[tilebgpal],0,0,46,1,noone)
    tilemap_complete=(bg_tilemode[tilebgpal]==7 or bg_tilemode[tilebgpal]==8)
    atcx=0
    atcy=0
}
