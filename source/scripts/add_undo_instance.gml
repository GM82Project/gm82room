add_undo(uid)
add_undo(obj)
add_undo(x)
add_undo(y)
add_undo(image_xscale)
add_undo(image_yscale)
add_undo(image_angle)
add_undo(image_blend)
add_undo(image_alpha)
add_undo(code)
add_undo(order)

var i; for (i=0;i<objfields[obj];i+=1) {
    add_undo(fields[i,0])
    if (fields[i,0]) {
        add_undo(fields[i,1])
        if (objfieldtype[obj,i] == "xy")
            add_undo(fields[i,2])
    }
}
