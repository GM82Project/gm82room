var h;

if (point_in_rectangle(mouse_wx,mouse_wy,0,120,160,height-332)) {
    if (mouse_check_button_pressed(mb_left)) {
        dy=pathscroll i=0 repeat (pathnum) {
            if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
                current_pathindex=i
                current_path=paths[i,0]
                current_pathpoint=0
                update_inspector()
            }
        i+=1 dy+=32}
        if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
            //create a new path
        }
    }
}
h=mouse_wheel_down()-mouse_wheel_up()
pathscrollgo-=h*120

pathscrollgo=clamp(pathscrollgo,-(pathnum+1)*32+(height-332-120),0)
pathscroll=clamp(inch((pathscroll*4+pathscrollgo)/5,pathscrollgo,2),-(pathnum+1)*32+(height-332-120),0)
