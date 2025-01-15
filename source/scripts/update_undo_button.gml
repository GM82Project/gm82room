with (Button) if (action="undo") {
    if (ds_list_empty(undostack)) {
        alt="Undo (empty)"
        global.modified=0
        room_caption=global.default_caption
    } else {
        if (total_undo_size/undospace>0.95) alt="Undo (full - oldest actions are being forgotten)"
        else alt="Undo "+ds_list_find_value(ds_list_find_value(undostack,0),1)+" ("+string((undospace-total_undo_size)/megabyte)+"MB free)"
        global.modified=1
        room_caption=global.default_caption+"*"
    }
}
