//Tile to Block
//Creates an instance of the currently selected object on top of selected tiles.##By Ubersaw Medic

var __objname,__depth,__sel,__selc;

if (mode!=1) {
    show_message("No tiles are selected. Please select some tiles.")
    exit
}

__depth=ds_list_find_value(layers,ly_current)

if (!num_selected()) {
    if (!show_question("No tiles are selected. Would you like to apply Tile to Block on all tiles from the current layer ("+string(__depth)+")?")) exit
    with (tileholder) if (tlayer==__depth) sel=true
}

__objname=ds_list_find_value(objects,objpal)
__selc=0

begin_undo(act_destroy,"Plugin: Tile to Block ("+__objname+")",0)

with (tileholder) if (sel) with (instance_create(x,y,instance)) {
    get_uid(id)
    obj=objpal
    objname=__objname
    depth=objdepth[obj]
    sprite_index=objspr[obj]
    if (!preciseclick) mask_index=objmaskr[obj]
    
    sprw=sprite_get_width(sprite_index)
    sprh=sprite_get_height(sprite_index)
    sprox=sprite_get_xoffset(sprite_index)
    sproy=sprite_get_yoffset(sprite_index)

    image_xscale=abs(other.image_xscale/(bbox_right+1-bbox_left))
    image_yscale=abs(other.image_yscale/(bbox_bottom+1-bbox_top))
    
    x-=bbox_left-other.bbox_left
    y-=bbox_top-other.bbox_top

    parse_code_into_fields(id,0)
    add_undo(uid)
    
    __sel[__selc]=id
    __selc+=1
}

push_undo()
project_modified()

change_mode(0)

selection=true
repeat (__selc) {
    __selc-=1
    __sel[__selc].sel=true
}
update_selection_bounds()
update_instance_memory()