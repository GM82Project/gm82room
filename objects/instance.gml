#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
sel=0
grab=0
rotato=0
draggatto=0
modified=0

rothandx=-9999999
rothandy=-9999999
draghandx=-9999999
draghandy=-9999999

code=""

instancecount+=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (Controller.select==id) {
    clear_inspector()
    Controller.select=noone
}

instancecount-=1

ds_map_delete(uidmap,uid)
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sel) {
    if (rotato) {
        image_angle=point_direction(x,y,global.mousex,global.mousey)+90-90*sign(image_xscale)
        if (!keyboard_check(vk_alt)) {
            image_angle=roundto(image_angle,15)
        }
        if (!mouse_check_direct(mb_left)) {rotato=0 event_user(1) do_change_undo("rotation",0)}
        update_inspector()
    }
    if (grab) {
        do_dragging()
        if (Controller.select==id) update_inspector()
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

        if (sprox>sprw*0.5) {
            image_xscale=-lengthdir_x(len,dir-image_angle)/(sprox)
        } else {
            image_xscale=lengthdir_x(len,dir-image_angle)/(sprw-sprox)
        }
        if (sproy>sprh*0.5) {
            image_yscale=-lengthdir_y(len,dir-image_angle)/(sproy)
        } else {
            image_yscale=lengthdir_y(len,dir-image_angle)/(sprh-sproy)
        }

        if (abs(image_xscale*sprw)<1) image_xscale=1/sprw
        if (abs(image_yscale*sprh)<1) image_yscale=1/sprh
        if (!mouse_check_direct(mb_left)) {draggatto=0 event_user(1) do_change_undo("scaling",0)}
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

if (sprox>sprw*0.5) {
    draghandx=x+lengthdir_x(-sprox*image_xscale,image_angle)
    draghandy=y+lengthdir_y(-sprox*image_xscale,image_angle)
} else {
    draghandx=x+lengthdir_x((sprw-sprox)*image_xscale,image_angle)
    draghandy=y+lengthdir_y((sprw-sprox)*image_xscale,image_angle)
}

if (sproy>sprh*0.5) {
    draghandx+=lengthdir_x(-sproy*image_yscale,image_angle-90)
    draghandy+=lengthdir_y(-sproy*image_yscale,image_angle-90)
} else {
    draghandx+=lengthdir_x((sprh-sproy)*image_yscale,image_angle-90)
    draghandy+=lengthdir_y((sprh-sproy)*image_yscale,image_angle-90)
}

if (draggatto) draw_line(x,y,draghandx,draghandy)
draw_rectangle(draghandx-8*zm,draghandy-8*zm,draghandx+8*zm,draghandy+8*zm,1)
draw_rectangle(draghandx-4*zm,draghandy-4*zm,draghandx+4*zm,draghandy+4*zm,1)

if (rotato) w=point_distance(x,y,global.mousex,global.mousey)*sign(image_xscale)
else w=sprw*image_xscale
rothandx=x+lengthdir_x(w,image_angle)
rothandy=y+lengthdir_y(w,image_angle)
if (point_distance(rothandx,rothandy,draghandx,draghandy)<20) {
    w=point_distance(x,y,draghandx,draghandy)+20
    rothandx=x+lengthdir_x(w,image_angle)
    rothandy=y+lengthdir_y(w,image_angle)
}

if (rotato) draw_line(x,y,rothandx,rothandy)
draw_circle(rothandx,rothandy,10*zm,1)
draw_circle(rothandx,rothandy,5*zm,1)

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

if (sign(image_xscale)==-1 && sign(image_yscale)==-1) {
    image_xscale=abs(image_xscale)
    image_yscale=abs(image_yscale)
    image_angle=(image_angle+180) mod 360
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw group selection

d3d_set_fog(1,$ff8000,0,0)
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,0,0.5+0.25*sin(current_time/200))
d3d_set_fog(0,0,0,0)

draw_set_color_sel()

draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+1-0.5,bbox_bottom+1-0.5,1)

draw_set_color($ffffff)
draw_set_alpha(1)
