//when called somewhere else, schedule a global save on the Controller
if (object_index=Controller) {
    begin_undo(act_change,undotype,undocombo)

    if (mode==0) {
        with (instance) {
            if (
                savex!=x ||
                savey!=y ||
                savez!=depth ||
                savexscale!=image_xscale ||
                saveyscale!=image_yscale ||
                saveangle!=image_angle ||
                saveblend!=image_blend ||
                savealpha!=image_alpha ||
                savecode!=code
            ) add_undo_instance_props()
        }
    }
    if (mode==1) {
        with (tileholder) {
            if (
                savex!=x ||
                savey!=y ||
                savelayer!=tlayer ||
                savexscale!=tilesx ||
                saveyscale!=tilesy ||
                saveblend!=image_blend ||
                savealpha!=image_alpha
            ) add_undo_tile_props()
        }
    }

    push_undo()

    update_instance_memory()
} else {
    Controller.undotype=argument[0]
    Controller.undocombo=argument[1]
    Controller.alarm[1]=2
}
