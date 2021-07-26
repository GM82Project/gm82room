#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
step()
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gameend()
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
create()
#define Other_30
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
game_end()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (state="load") {
    draw_clear(global.col_main)
    draw_text(32,8,loadtext)
    buttoncol=global.col_main
    draw_button(32,32,256,32,0)
    u=(256-8)*progress

    if (u) {
        draw_rectangle(36,36,36+u-1,36+32-8-1,0)
    }
} else {
    d3d_set_projection_ortho(0.5,0.5,width,height,0)
    d3d_draw_floor(0,0,0,width,height,0,bgtex,width/200,height/200)
    d3d_reset_projection()
    if (backvisible) rect(0,0,roomwidth,roomheight,background_color,1)
    else rect(0,0,roomwidth,roomheight,fillcolor,1)
}
