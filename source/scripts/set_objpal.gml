//sets objpal and updates the name

textfield_set("palette name",ds_list_find_value(objects,argument0))
objpal=argument0

if (gridmem) {
    gridx=gridmemx
    gridy=gridmemy
    gridox=gridmemox
    gridoy=gridmemoy
    gridmem=false

    with (TextField) if (action=="grid x") {text=string(gridx) event_user(4)}
    with (TextField) if (action=="grid y") {text=string(gridy) event_user(4)}
    with (TextField) if (action=="grid ox") {text=string(gridox) event_user(4)}
    with (TextField) if (action=="grid oy") {text=string(gridoy) event_user(4)}
}

if (objoverride[objpal,ovr_grid]) {
    gridmemx=gridx
    gridmemy=gridy
    gridmemox=gridox
    gridmemoy=gridoy
    gridmem=true

    gridx=objoverride[objpal,ovr_grid_x]
    gridy=objoverride[objpal,ovr_grid_y]
    gridox=objoverride[objpal,ovr_grid_ox]
    gridoy=objoverride[objpal,ovr_grid_oy]

    with (TextField) if (action=="grid x") {text=string(gridx) event_user(4)}
    with (TextField) if (action=="grid y") {text=string(gridy) event_user(4)}
    with (TextField) if (action=="grid ox") {text=string(gridox) event_user(4)}
    with (TextField) if (action=="grid oy") {text=string(gridoy) event_user(4)}
}
