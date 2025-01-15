begin_undo(act_create,"cleaning duplicate instances",0)
with (instance) if (obj==objpal) {
    with (instance) if (obj==objpal && id<other.id)
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
