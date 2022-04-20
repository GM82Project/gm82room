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
selresize=0

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
if (selectt==id) {
    clear_inspector()
    selectt=noone
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
        if (selectt==id) update_inspector()
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
    if (selresize) {
        do_selection_resize()
        tilesx=image_xscale/tilew
        tilesy=image_yscale/tileh
        tile_set_position(tile,x,y)
        tile_set_scale(tile,tilesx,tilesy)
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
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///sanitize scale

if (abs(image_xscale*tilew)<1) image_xscale=1
if (abs(image_yscale*tileh)<1) image_yscale=1

tilesx=image_xscale/tilew
tilesy=image_yscale/tileh

tile_set_scale(tile,tilesx,tilesy)
