var error,count,dx,dy;

error=""
count=0

with (instance) if (sel and image_angle==0) {
    count+=ceil(sprite_width/gridx)*ceil(sprite_height/gridy)
}

if (count>1000)
    if (!show_question("WARNING: your current selection with the set grid size ("+string(gridx)+","+string(gridy)+") will cause "+string(count)+" new instances to be created.##Are you sure you want to continue?"))
        exit

begin_undo(act_create,"",0)
with (instance) if (sel) {
    add_undo_instance()
}
push_undo()

with (instance) if (sel) {
    if (image_angle!=0) error+="instance "+uid+" at ("+string(x)+","+string(y)+") is rotated and can't be gigaknifed#"
    else {
        //split by grid
        var dx,dy;

        dx=x dy=y
        dw=sprite_width
        dh=sprite_height

        //we 9-slice dat shizz
        if (dx mod gridx and dy mod gridy) {
            //top left
        }
        if ((dx+dw) mod gridx and dy mod gridy) {
            //top right
        }
        if (dx mod gridx and (dy+dh) mod gridy) {
            //bottom left
        }
        if ((dx+dw) mod gridx and (dy+dh) mod gridy) {
            //bottom right
        }

        if (dx mod gridx) {
            //left
        }
        if ((dx+dw) mod gridx) {
            //right
        }
        if (dy mod gridy) {
            //top
        }
        if ((dy+dh) mod gridy) {
            //bottom
        }

        //middle bit


        create_french_fry()

        instance_destroy()
    }
}

begin_undo(act_destroy,"Subdivide instances",1)
    with (instance) if (modified) {add_undo(uid) modified=0 sel=1}
push_undo()

change_mode(mode)

if (error!="") show_message("There were errors using the Gigaknife tool:##"+error)
