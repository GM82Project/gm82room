if (!show_question("Clean Stacked Copies##This tool will delete any identical instances from the room. Note that this only checks for same object, position, and scaling.##Proceed?")) exit

begin_undo(act_create,"cleaning duplicate instances",0)

var checksel;checksel=!!num_selected()

with (instance) if (sel==checksel) {
    with (instance) if (sel==checksel && obj==other.obj && id<other.id)
        if (
            x==other.x
         && y==other.y
         && image_xscale==other.image_xscale
         && image_yscale==other.image_yscale
         && image_angle==other.image_angle
         && image_blend==other.image_blend
         && image_alpha==other.image_alpha
         && code==other.code
        ) {
            add_undo_instance()
            instance_destroy()
        }
}
push_undo()
