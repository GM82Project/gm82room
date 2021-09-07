#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
change_mode(mode)
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
do_change_undo()
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
d3d_set_projection_ortho(0,0,width,height,0)
d3d_draw_floor(0.5,0.5,0,width,height,0,bgtex,width/200,height/200)

if (theme==1) {
    draw_set_blend_mode_ext(10,1)
    rect(0,0,width,height,$ffffff,1)
    draw_set_blend_mode(0)
}

d3d_reset_projection()

draw_backgrounds(0)
