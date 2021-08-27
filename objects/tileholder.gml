#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tile=noone
tilesx=1
tilesy=1
blend=$ffffffff

sel=0
grab=0
draggatto=0
modified=0

rothandx=-9999999
rothandy=-9999999
draghandx=-9999999
draghandy=-9999999

tilecount+=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (Controller.selectt==id) {
    clear_inspector()
    Controller.selectt=noone
}

if (tile!=noone) {
    tilecount-=1
    tile_delete(tile)
}

ds_map_delete(uidmap,uid)
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sel) {
    if (grab) {
        do_dragging()
        tile_set_position(tile,x,y)
        if (Controller.selectt==id) update_inspector()
    }
    if (draggatto) {
        dx=global.mousex
        dy=global.mousey

        if (!keyboard_check(vk_alt)) {
            dx=roundto(dx,gridx)
            dy=roundto(dy,gridy)
        }

        dir=point_direction(x,y,dx,dy)
        len=point_distance(x,y,dx,dy)

        image_xscale=lengthdir_x(len,dir)
        image_yscale=lengthdir_y(len,dir)

        if (abs(image_xscale*tilew)<1) image_xscale=1
        if (abs(image_yscale*tileh)<1) image_yscale=1

        tilesx=image_xscale/tilew
        tilesy=image_yscale/tileh

        tile_set_scale(tile,tilesx,tilesy)

        if (!mouse_check_direct(mb_left)) {draggatto=0 do_change_undo("scaling",0)}
        update_inspector()
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw selection handles

d3d_transform_add_translation(-0.5,-0.5,0)
draw_set_color_sel()

zm=max(0.5,zoom)

draw_rectangle(bbox_left,bbox_top,bbox_right+1,bbox_bottom+1,1)
draw_circle(x,y,4*zm,1)
draw_line(x,y-4*zm,x,y+4*zm)
draw_line(x-4*zm,y,x+4*zm,y)

if (extended_instancedata) {
    draghandx=x+image_xscale
    draghandy=y+image_yscale

    if (draggatto) draw_line(x,y,draghandx,draghandy)
    draw_rectangle(draghandx-8*zm,draghandy-8*zm,draghandx+8*zm,draghandy+8*zm,1)
    draw_rectangle(draghandx-4*zm,draghandy-4*zm,draghandx+4*zm,draghandy+4*zm,1)
}

draw_set_color($ffffff)
draw_set_alpha(1)
d3d_transform_set_identity()
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw group selection

draw_set_color($ff8000)
draw_set_alpha(0.5+0.25*sin(current_time/200))
draw_rectangle(x-0.5,y-0.5,x+image_xscale-0.5,y+image_yscale-0.5,0)
draw_set_color($ffffff)
draw_set_alpha(1)

draw_set_color_sel()

draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+1-0.5,bbox_bottom+1-0.5,1)

draw_set_color($ffffff)
draw_set_alpha(1)
