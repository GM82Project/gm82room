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
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.livesock!=noone) live_send_room_data()
#define Alarm_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[3]=room_speed/2
if (global.livesock!=noone) {
    var yes;yes=0
    if (mode==0) with (select) if (rotato || draggatto) yes=1
    if (mode==1) with (selectt) if (draggatto) yes=1
    if (yes) live_send_room_data()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
step()
#define Other_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dx8_set_vsync(0)
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
if (global.modified) if (show_message_ext("Are you sure you want to quit?##There are unsaved changes.","Quit","","Stay")!=1) exit

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

dx8_reset_projection()

if (knobz!=0 || knobx!=0 || knoby!=0) {
    d3d_start()
    dx8_clear_depth_buffer()
    var xc,yc;

    xc=view_xview+view_wview/2
    yc=view_yview+view_hview/2

    d3d_set_projection_ext(
        xc,yc,-view_hview/2,
        xc,yc,0,
        0,-1,0,
        90,
        -view_wview/view_hview,
        1,16777215
    )
    d3d_transform_add_scaling(1,1,knobz)
    d3d_transform_add_translation(-xc,-yc,0)
    d3d_transform_add_rotation_x(knobx)
    d3d_transform_add_rotation_y(knoby)
    d3d_transform_add_translation(xc,yc,0)
}

draw_backgrounds(0)
