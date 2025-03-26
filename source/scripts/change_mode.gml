var i,layer,deact,dcur;

dcur=0
ref_moving=0

if (mode!=argument) {
    deselect()
}

mode=argument0

ds_priority_clear(click_priority)

//instances
instance_activate_object(instance)
instancecount=instance_number(instance)
with (instance) {
    fieldactive=0
    visible=((view[0] && (view[5] || objvis[obj]) && (view[6] || objspr[obj]!=sprDefault) && (objshow[obj] || view[10])) || (argument0==0 && objpal==obj))
    if (!visible) {
        sel=0
        if (select==id) {
            select=noone
            clear_inspector()
        }
        deact[dcur]=id dcur+=1
    }
}

//tiles
if (argument0==1) {
    instance_activate_object(tileholder)
    update_tilepanel()
} else {
    instance_deactivate_object(tileholder)
}
tilecount=instance_number(tileholder)

if (argument0 <2) update_selection_bounds()
if (argument0==2) update_backgroundpanel()
if (argument0==3) update_viewpanel()
if (argument0==4) update_settingspanel()

ly_depth=ds_list_find_value(layers,ly_current)

if (view[1]) {
    for (i=0;i<ds_list_size(layers);i+=1) {
        layer=ds_list_find_value(layers,i)
        tile_layer_show(layer)
        if (ly_current!=i && argument0==1) {
            with (tileholder) if (tlayer==layer) {deact[dcur]=id dcur+=1}
        }
    }
} else {
    for (i=0;i<ds_list_size(layers);i+=1) {
        layer=ds_list_find_value(layers,i)
        if (ly_current==i && argument0==1) tile_layer_show(layer)
        else {
            tile_layer_hide(layer)
            with (tileholder) if (tlayer==layer) {deact[dcur]=id dcur+=1}
        }
    }
}

i=0
repeat (dcur) {
    instance_deactivate_object(deact[i])
    i+=1
}
