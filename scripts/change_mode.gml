//if (mode==0 || argument0==0) {
    //instances
    instance_activate_object(instance)
    instancecount=instance_number(instance)
    with (instance) {
        visible=((view[0] && (view[5] || objvis[obj]) && (view[6] || objspr[obj]!=sprDefault)) || (argument0==0 && objpal==obj))
        if (!visible) {
            sel=0
            if (Controller.select==id) {
                Controller.select=noone
                clear_inspector()
            }
            alarm[0]=1
        }
    }
//}

//if (mode==1 || argument0==1) {
    if (argument0==1) {
        instance_activate_object(tileholder)
    } else {
        instance_deactivate_object(tileholder)
    }

    //tiles
    if (view[1]) {
        for (i=0;i<ds_list_size(layers);i+=1) {
            tile_layer_show(ds_list_find_value(layers,i))
        }
    } else {
        for (i=0;i<ds_list_size(layers);i+=1) {
            if (ly_current==i && argument0==1) tile_layer_show(ds_list_find_value(layers,i))
            else tile_layer_hide(ds_list_find_value(layers,i))
        }
    }
//}

mode=argument0
