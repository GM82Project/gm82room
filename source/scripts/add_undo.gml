current_undo_size+=24
if (is_string(argument0)) current_undo_size+=string_length(argument0)

ds_list_add(undolist,argument0)
