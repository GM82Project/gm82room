if (mode==1) instance_activate_object(tileholder)
else instance_deactivate_object(tileholder)

if (argument0==0) {
    //instances
    instance_activate_object(instance)
    instancecount=instance_number(instance)
    with (instance) {
        visible=((view[0] && (view[5] || objvis[obj]) && (view[6] || objspr[obj]!=sprDefault)) || (mode==0 && objpal==obj))
        if (!visible) {
            sel=0
            if (Controller.select==id) Controller.select=noone
            alarm[0]=1
        }
    }
}

if (argument0==1) {
    //tiles
    //if (view[1]) {
}
