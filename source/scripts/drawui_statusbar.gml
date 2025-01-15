statusx=160
statusy=height-32
statusw=width-320
statush=32

draw_button_ext(statusx,height-32,144,32,0,global.col_main)
draw_button_ext(statusx+144,height-32,296,32,0,global.col_main)
draw_button_ext(statusx+440,height-32,48,32,0,pick(overmode,global.col_main,$ff))
draw_button_ext(statusx+488,height-32,width-320-488,32,0,global.col_main)
draw_set_color(global.col_text)
draw_text(statusx+448,statusy+6,pick(overmode,"INS","OVR"))
if (keyboard_check(vk_alt)) draw_text(statusx+8,statusy+6,string(global.mousex)+","+string(global.mousey))
else draw_text(statusx+8,statusy+6,string(fmx)+","+string(fmy))
if (mode==0) {
    num=instance_number(instance)
    if (num<instancecount) draw_text(statusx+152,statusy+6,string(num)+" instances ("+string(instancecount-num)+" hidden)")
    else draw_text(statusx+152,statusy+6,string(instancecount)+" instances")
    if (focus) draw_text(statusx+496,statusy+6,focus.objname+" ("+focus.uid+") "+string(focus.x)+","+string(focus.y))
}
if (mode==1) {
    num=instance_number(tileholder)
    if (view[1]) draw_text(statusx+152,statusy+6,string(tilecount)+" tiles")
    else if (num<tilecount) draw_text(statusx+152,statusy+6,string(num)+" tiles ("+string(tilecount-num)+" hidden)")
    else draw_text(statusx+152,statusy+6,string(num)+" tiles")
    if (focus) draw_text(statusx+496,statusy+6,string(focus.bgname)+" "+string(focus.x)+","+string(focus.y))
}
draw_set_color($ffffff)
