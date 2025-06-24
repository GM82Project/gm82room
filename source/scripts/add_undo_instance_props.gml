add_undo(uid)
add_undo(savex)
add_undo(savey)
add_undo(savez)
add_undo(savexscale)
add_undo(saveyscale)
add_undo(saveangle)
add_undo(saveblend)
add_undo(savealpha)
add_undo(savecode)

var i; for (i=0;i<objfields[obj];i+=1) {
    add_undo(fields[i,0])
    if (fields[i,0]) {
        add_undo(fields[i,1])
        if (objfieldtype[obj,i] == "xy")
            add_undo(fields[i,2])
    }
}
