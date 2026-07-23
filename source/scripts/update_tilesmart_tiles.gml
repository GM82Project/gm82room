var list,c;

c=0 with (tileholder) if (post_brush_update) {list[c]=id c+=1}

if (c) {
    instance_deactivate_object(tileholder)

    repeat (c) {c-=1 instance_activate_object(list[c])}

    with (tileholder) event_user(2)

    instance_activate_object(tileholder)
}
