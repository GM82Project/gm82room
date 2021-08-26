globalvar undostack,undolist,undoing,uidmap,lastuid,current_undo_size,total_undo_size;

undostack=ds_list_create()
undoing=0
lastuid=0
uidmap=ds_map_create()

current_undo_size=0
total_undo_size=0
