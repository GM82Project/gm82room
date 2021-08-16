///begin_undo(action_type)

Controller.undolist=ds_list_create()
ds_list_add(Controller.undolist,argument0)
ds_list_add(Controller.undolist,mode)
Controller.undoing=1
