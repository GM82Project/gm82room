var h,oldpath;

if (point_in_rectangle(mouse_wx,mouse_wy,0,120,160,height-328)) {
    if (mouse_check_button_pressed(mb_left)) {
        dy=pathscroll i=0 repeat (pathnum) {
            if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
                oldpath=current_pathindex
                current_pathindex=i
                current_path=paths[i,0]
                current_pathpoint=path_get_number(current_path)-1
                if (oldpath!=noone) generate_path_model(oldpath)
                generate_path_model(i)
                update_inspector()
            }
        i+=1 dy+=32}
        if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
            //create a new path
            current_path=path_add()
            paths[pathnum,0]=current_path
            paths[pathnum,1]="path"+string(path_indexsize) path_indexsize+=1
            paths[pathnum,3]=d3d_model_create()
            paths[pathnum,4]=true //new to this session
            paths[pathnum,5]=true //modified
            path_set_closed(current_path,0)
            path_set_precision(current_path,4)
            path_set_kind(current_path,0)
            path_add_point(current_path,round(xgo),round(ygo),100)

            oldpath=current_pathindex
            current_pathindex=pathnum
            current_pathpoint=0
            if (oldpath!=noone) generate_path_model(oldpath)
            generate_path_model(current_pathindex)
            update_inspector()

            pathnum+=1
        }
    }
    h=mouse_wheel_down()-mouse_wheel_up()
    pathscrollgo-=h*120
}

pathscrollgo=clamp(pathscrollgo,-(pathnum+1)*32+(height-328-120),0)
pathscroll=clamp(inch((pathscroll*4+pathscrollgo)/5,pathscrollgo,2),-(pathnum+1)*32+(height-328-120),0)
