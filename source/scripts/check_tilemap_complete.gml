var maxx,maxy,i,variantx,varianty;

if (tilebgpal==noone) tilemap_complete=false
else if (bg_tilemode[tilebgpal]==7 or bg_tilemode[tilebgpal]==8) tilemap_complete=true
else if (ds_grid_get_min(bg_tilemap[tilebgpal],0,0,pick(bg_tilemode[tilebgpal]-1,1,2,4,9,16,47)-1,1)!=noone) {
    variantx=ds_grid_get(bg_tilemap[tilebgpal],47,0)
    varianty=ds_grid_get(bg_tilemap[tilebgpal],47,1)

    if (variantx<=0 or varianty<=0) {
        variantx=1
        varianty=1
        ds_grid_set(bg_tilemap[tilebgpal],47,0,1)
        ds_grid_set(bg_tilemap[tilebgpal],47,1,1)
    }

    maxx=(bgw/variantx)
    maxy=(bgh/varianty)

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

autotiler_is_adjacent=0

if (replace or argument2) if (bg_tilemode[tilebgpal]!=1 and bg_tilemode[tilebgpal]!=7 and bg_tilemode[tilebgpal]!=8) autotiler_is_adjacent=1
