///draw_tilesmart_brush(x,y,enable)
var replace,index,byte,left,top,i,tile1,tile2;

if (tilebgpal==noone) exit
if (!tilemap_complete) exit

//delete overlap
instance_destroy_id(find_smart_tile_at(argument0+gridx/2,argument1+gridy/2))

if (bg_tilemode[tilebgpal]!=6) {
    tile1[0]=find_smart_tile_at(argument0-gridx*0.5,argument1-gridy*0.5)
    tile1[1]=find_smart_tile_at(argument0+gridx*0.5,argument1-gridy*0.5)
    tile1[2]=find_smart_tile_at(argument0+gridx*1.5,argument1-gridy*0.5)
    tile1[3]=find_smart_tile_at(argument0-gridx*0.5,argument1+gridy*0.5)
    tile1[4]=find_smart_tile_at(argument0+gridx*1.5,argument1+gridy*0.5)
    tile1[5]=find_smart_tile_at(argument0-gridx*0.5,argument1+gridy*1.5)
    tile1[6]=find_smart_tile_at(argument0+gridx*0.5,argument1+gridy*1.5)
    tile1[7]=find_smart_tile_at(argument0+gridx*1.5,argument1+gridy*1.5)
}

if (argument2) {//add tile
    //decode tile coordinate
    if (bg_tilemode[tilebgpal]==6) {
        left=argument0 mod background_get_width(bg_background[tilebgpal])
        top=argument1 mod background_get_height(bg_background[tilebgpal])
    } else {
        byte=pack_bools(tile1[7],tile1[6],tile1[5],tile1[4],tile1[3],tile1[2],tile1[1],tile1[0])
        index=autotiler_tables[bg_tilemode[tilebgpal],byte]
        left=ds_grid_get(bg_tilemap[tilebgpal],index,0)
        top=ds_grid_get(bg_tilemap[tilebgpal],index,1)
    }

    o=instance_create(argument0,argument1,tileholder) get_uid(o)
    o.bgname=tilebgname
    o.bg=bg_background[tilebgpal]
    o.tilew=Tilepanel.gx
    o.tileh=Tilepanel.gy
    o.image_xscale=gridx
    o.image_yscale=gridy
    o.tile=tile_add(bg_background[tilebgpal],left,top,o.tilew,o.tileh,o.x,o.y,ly_depth)
    o.tilesx=gridx/o.tilew
    o.tilesy=gridy/o.tileh
    tile_set_scale(o.tile,o.tilesx,o.tilesy)
    o.tlayer=ly_depth o.depth=ly_depth-0.01
    o.modified=1
    update_instance_memory(o)
}

if (bg_tilemode[tilebgpal]!=6) {
    //update surrounding tiles
    i=0 repeat (8) {
        with (tile1[i]) {
            tile2[0]=find_smart_tile_at(x-gridx*0.5,y-gridy*0.5)
            tile2[1]=find_smart_tile_at(x+gridx*0.5,y-gridy*0.5)
            tile2[2]=find_smart_tile_at(x+gridx*1.5,y-gridy*0.5)
            tile2[3]=find_smart_tile_at(x-gridx*0.5,y+gridy*0.5)
            tile2[4]=find_smart_tile_at(x+gridx*1.5,y+gridy*0.5)
            tile2[5]=find_smart_tile_at(x-gridx*0.5,y+gridy*1.5)
            tile2[6]=find_smart_tile_at(x+gridx*0.5,y+gridy*1.5)
            tile2[7]=find_smart_tile_at(x+gridx*1.5,y+gridy*1.5)

            byte=pack_bools(tile2[7],tile2[6],tile2[5],tile2[4],tile2[3],tile2[2],tile2[1],tile2[0])
            index=autotiler_tables[bg_tilemode[tilebgpal],byte]
            left=ds_grid_get(bg_tilemap[tilebgpal],index,0)
            top=ds_grid_get(bg_tilemap[tilebgpal],index,1)

            tile_set_region(tile,left,top,tilew,tileh)
            modified=1
        }
    i+=1}
}
