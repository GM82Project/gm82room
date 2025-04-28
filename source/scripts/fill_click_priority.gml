var prio;

if (argument_count) prio=argument[0] else prio=click_priority

ds_priority_clear(prio)

//sort by reverse scale

if (mode==0) with (instance)
    if (distance_to_point(global.mousex,global.mousey)<1)
        if (instance_position(global.mousex,global.mousey,id))
            ds_priority_add(prio,id,(max_int-depth)/abs(sprite_width*sprite_height))

if (mode==1) with (tileholder)
    if (distance_to_point(global.mousex,global.mousey)<1)
        if (instance_position(global.mousex,global.mousey,id))
            ds_priority_add(prio,id,(max_int-depth)/abs(tilesx*tilew*tilesy*tileh))

return ds_priority_size(prio)
