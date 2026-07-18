if (tilebgpal==noone) tilemap_complete=0
else tilemap_complete=ds_grid_get_min(bg_tilemap[tilebgpal],0,0,pick(bg_tilemode[tilebgpal]-1,2,4,9,16,47)-1,1)!=noone
