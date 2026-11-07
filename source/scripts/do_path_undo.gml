///do_path_undo(description,nopoints)

begin_undo(act_path,argument0,0)

var n,i;

if (undoing) {
    add_undo(current_pathname)
    add_undo(path_get_closed(current_path))
    add_undo(path_get_kind(current_path))
    add_undo(path_get_precision(current_path))
    add_undo(current_pathpoint)
    if (argument1) add_undo(0)
    else {
        n=path_get_number(current_path)
        add_undo(n)
        i=0 repeat (n) {
            add_undo(path_get_point_x(current_path,i))
            add_undo(path_get_point_y(current_path,i))
            add_undo(path_get_point_speed(current_path,i))
        i+=1}
    }
}

push_undo()
