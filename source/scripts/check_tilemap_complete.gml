var maxx,maxy,i;

if (tilebgpal==noone) tilemap_complete=false
else if (bg_tilemode[tilebgpal]==7 or bg_tilemode[tilebgpal]==8) tilemap_complete=true
else if (ds_grid_get_min(bg_tilemap[tilebgpal],0,0,pick(bg_tilemode[tilebgpal]-1,1,2,4,9,16,47)-1,1)!=noone) {
    maxx=(bgw/ds_grid_get(bg_tilemap[tilebgpal],47,0))
    maxy=(bgh/ds_grid_get(bg_tilemap[tilebgpal],47,1))

    tilemap_complete=0

    //check for any tiles outside the variant area
    i=0 repeat (pick(bg_tilemode[tilebgpal]-1,1,2,4,9,16,47)) {
        if (ds_grid_get(bg_tilemap[tilebgpal],i,0)+Tilepanel.gx>maxx)
        or (ds_grid_get(bg_tilemap[tilebgpal],i,1)+Tilepanel.gy>maxy) {
            tilemap_complete=-1
            exit
        }
    i+=1}

    tilemap_complete=1
}
