var yes;

if (resizecount<5) {
    if (window_get_width()!=width || window_get_height()!=height) {
        with (Button) if (anchor==1) offx=width-x
        width=max(912,window_get_width())
        height=max(704,window_get_height())
        window_set_size(width,height)
        window_set_region_size(width,height,0)
        window_resize_buffer(width,height)
        view_wport[0]=width
        view_hport[0]=height
        with (Button) if (anchor==1) x=width-offx
        resizecount+=1
        if (resizecount>=5) show_message("Resizing the window failed multiple times. Do you have some sort of weird DPI settings? Either way, I'm disabling resizing for now.")
    } else resizecount=0
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))) with (instance) sel=1

mouse_wx=window_mouse_get_x()
mouse_wy=window_mouse_get_y()

mousein=(point_in_rectangle(mouse_wx,mouse_wy,160,32,width-160,height-32))

if (mouse_check_button_pressed(mb_left)) {
    with (Button) event_user(2)

    if (!mousein) {
        //click on menus
        with (instance_position(mouse_wx,mouse_wy,Button)) {
            down=1
        }
    } else {
        //click on workspace
        yes=0
        //if something's already selected, operate on it
        with (select) {
            if (position_meeting(mouse_x,mouse_y,id) && keyboard_check(vk_control)) {
                grab=1
                offx=mouse_x-x
                offy=mouse_y-y
                yes=1
            } else if (point_distance(rothandx,rothandy,mouse_x,mouse_y)<10) {
                rotato=1
                yes=1
            } else if (abs(mouse_x-draghandx)<8 && abs(mouse_y-draghandy)<8) {
                draggatto=1
                yes=1
            }
        }
        if (!instance_exists(select) || !yes) {
            clear_inspector()
            if (!keyboard_check(vk_shift)) with (instance) sel=0
            select=noone
            with (instance) {
                if (position_meeting(mouse_x,mouse_y,id)) {
                    sel=1
                    update_inspector()
                    //ctrl+left = move
                    if (keyboard_check(vk_control)) {
                        grab=1
                        offx=mouse_x-x
                        offy=mouse_y-y
                        //group operation
                        with (instance) if (sel) {
                            grab=1
                            offx=mouse_x-x
                            offy=mouse_y-y
                        }
                    } else with (other.select) sel=0
                    other.select=id
                }
            }
            if (!select) {
                //if not holding control, reset selection
                if (!keyboard_check(vk_control)) with (instance) sel=0
                if (keyboard_check(vk_shift)) {
                    //selection rectangle
                    selecting=1
                    selx=mouse_x
                    sely=mouse_y
                } else {
                    //paint
                    //i=instance_create(mouse_x,mouse_y,instance)
                }
            }
        }
    }
}

if (selecting) {
    with (instance) {
        if (collision_rectangle(other.selx,other.sely,mouse_x,mouse_y,id,1,0)) sel=1
    }
    if (!mouse_check_direct(mb_left)) selecting=0
}


if (mouse_check_direct(mb_right)) {
    if (selecting) selecting=0
    //delete instances
    if (!mouse_check_direct(mb_left)) {
        instance_destroy_id(instance_position(mouse_x,mouse_y,instance))
    }
}


//panning
if (mouse_check_button_pressed(mb_middle)) {
    //yeah i know i called pan zooming but ok just think like youre zooming around im sorry
    zooming=1
    grabx=mouse_x
    graby=mouse_y
}

if (!mouse_check_direct(mb_middle)) {
    zooming=0
}

if (zooming) {
    xgo+=grabx-mouse_x
    ygo+=graby-mouse_y
}


//zooming
if (!zoomcenter) {
    if (mouse_wheel_down()) zoomgo*=1.2
    if (mouse_wheel_up()) zoomgo/=1.2
}

zoomold=zoom

if (abs(zoom-1)<0.1) {
    if ((zoomgo>1 && zoom<1) || (zoomgo<1 && zoom>1) || (zoom==1 && zoomgo==1)) {
        zoomgo=1
        zoom=1
        zoomcenter=0
    }
}

zoomgo=median(1/8,zoomgo,32)
zoom=inch((zoom*9+zoomgo)/10,zoomgo,0.02)

if (!zoomcenter) {
    xgo-=(mouse_wx-width*0.5)*(zoom-zoomold)
    ygo-=(mouse_wy-height*0.5)*(zoom-zoomold)
}


//update view
texture_set_interpolation(interpolation)

view_xview[0]=floor(xgo-width*0.5*zoom)
view_yview[0]=floor(ygo-height*0.5*zoom)
view_wview[0]=width*zoom
view_hview[0]=height*zoom
