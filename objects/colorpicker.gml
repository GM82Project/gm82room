#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
w=488
h=376

k=360/255
s=-1
s2=-1

act=""
button=1
grab=0
text=""

undo=0
postundo=0

customcolor=noone

offx=(width-w) div 2
offy=(height-h-32) div 2
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surface_free(s)
surface_free(s2)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//input
if (keyboard_check(vk_escape)) {
    color=oldcolor
    event_user(0)
    if (!postundo) pop_undo()
    instance_destroy()
    exit
}
if (keyboard_check(vk_control)) {
    if (keyboard_check(ord("C"))) {
        col=string_hex(color)
        clipboard_set_text("$"+string_repeat("0",6-string_length(col))+col)
    }
    if (keyboard_check(ord("V"))) {
        color=real_hex(clipboard_get_text())&$ffffff
        hue=color_get_hue(color)
        sat=color_get_saturation(color)
        val=color_get_value(color)
        red=color_get_red(color)
        green=color_get_green(color)
        blue=color_get_blue(color)
    }
}

mouse_wx=window_mouse_get_x()
mouse_wy=window_mouse_get_y()

mx=mouse_wx-offx
my=mouse_wy-offy

button=mouse_check_button(mb_left)
pressed=mouse_check_button_pressed(mb_left)
released=mouse_check_button_released(mb_left)

if (grab) {
    offx=mouse_wx-grabx
    offy=mouse_wy-graby
    if (!button) grab=0
}

offx=median(0,offx,width-w)
offy=median(32,offy,height-h)

if (point_in_rectangle(mx,my,0,-32,w,0)) {
    current_cursor=cr_size_all
}

if (pressed) {
    if (point_in_rectangle(mx,my,0,-32,w,0)) {
        grab=1
        grabx=mouse_wx-offx
        graby=mouse_wy-offy
    }

    //big palette
    if (point_in_rectangle(mx,my,8,8,8+256+8,8+144)) {
        color=mspal[((mx-8) div 33)+((my-8) div 24)*8]
        hue=color_get_hue(color)
        if (color==0) sat=255 else sat=color_get_saturation(color)
        val=color_get_value(color)
        red=color_get_red(color)
        green=color_get_green(color)
        blue=color_get_blue(color)
        customcolor=noone
    }

    //custom colors
    if (point_in_rectangle(mx,my,8,160,8+256+8,160+48)) {
        customcolor=((mx-8) div 33)+((my-160) div 24)*8
        color=customcolors[customcolor]
        hue=color_get_hue(color)
        if (color==0) sat=255 else sat=color_get_saturation(color)
        val=color_get_value(color)
        red=color_get_red(color)
        green=color_get_green(color)
        blue=color_get_blue(color)
    }

    //color wheel
    if (point_in_rectangle(mx,my,278,10,278+200,10+200)) {
        d=point_distance(278+100,10+100,mx,my)
        if (d<=100 && d>80) act="grabwheel"
        if (d<=80) act="grabprism"
    }

    //sliders
    if (point_in_rectangle(mx,my,8,216,8+256+8,216+24)) {
        act="grabred"
        graby=216+24-5
    }
    if (point_in_rectangle(mx,my,8,216+24,8+256+8,216+24+24)) {
        act="grabgreen"
        graby=216+24+24-5
    }
    if (point_in_rectangle(mx,my,8,216+48,8+256+8,216+24+48)) {
        act="grabblue"
        graby=216+24+48-5
    }
    if (point_in_rectangle(mx,my,8,296,8+256+8,296+24)) {
        act="grabhue"
        graby=296+24-5
    }
    if (point_in_rectangle(mx,my,8,296+24,8+256+8,296+24+24)) {
        act="grabsat"
        graby=296+24+24-5
    }
    if (point_in_rectangle(mx,my,8,296+48,8+256+8,296+24+48)) {
        act="grabval"
        graby=296+24+48-5
    }

    //color textfields
    //hoooooly shit
    if (point_in_rectangle(mx,my,256+20,216,256+20+40,216+24)) {
        text="red"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,216,256+64+52,216+24)) {
        text="red%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,256+20,216+24,256+20+40,216+24+24)) {
        text="green"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,216+24,256+64+52,216+24+24)) {
        text="green%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,256+20,216+48,256+20+40,216+48+24)) {
        text="blue"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,216+48,256+64+52,216+48+24)) {
        text="blue%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,256+20,296,256+20+40,296+24)) {
        text="hue"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,296,256+64+52,296+24)) {
        text="hue%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,256+20,296+24,256+20+40,296+24+24)) {
        text="sat"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,296+24,256+64+52,296+24+24)) {
        text="sat%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,256+20,296+48,256+20+40,296+48+24)) {
        text="val"
        act="typing"
        keyboard_string=""
    }
    if (point_in_rectangle(mx,my,256+64,296+48,256+64+52,296+48+24)) {
        text="val%"
        act="typing"
        keyboard_string=""
    }

    if (point_in_rectangle(mx,my,380,296,380+100,296+24)) {
        text="hex"
        act="typing"
        keyboard_string=""
    }

    //buttons
    if (point_in_rectangle(mx,my,380,328,380+48,328+40)) {
        act="grabcancel"
    }
    if (point_in_rectangle(mx,my,432,328,432+48,328+40)) {
        act="grabok"
    }
}

if (act=="typing") {
    if (keyboard_check_pressed(vk_enter)) {
        act=""
        text=""
    }
    if (text=="hex") keyboard_string=string_copy(string_hexdigits(keyboard_string),1,6)
    else keyboard_string=string_copy(string_digits(keyboard_string),1,3)

    if (keyboard_string!="") {
        makehue=0
        makergb=0
        if (text=="hex") {
            color=median(0,real_hex(keyboard_string),$ffffff)
            makergb=1
            makehue=1
        } else {
            if (text=="hue%") value=median(0,real(keyboard_string),360)
            else if (string_pos("%",text)) value=median(0,round(real(keyboard_string)*2.55),255)
            else value=median(0,real(keyboard_string),255)

            if (text=="red") {red=value color=make_color_rgb(red,green,blue) makehue=1}
            if (text=="green") {green=value color=make_color_rgb(red,green,blue) makehue=1}
            if (text=="blue") {blue=value color=make_color_rgb(red,green,blue) makehue=1}
            if (text=="red%") {red=value color=make_color_rgb(red,green,blue) makehue=1}
            if (text=="green%") {green=value color=make_color_rgb(red,green,blue) makehue=1}
            if (text=="blue%") {blue=value color=make_color_rgb(red,green,blue) makehue=1}

            if (text=="hue") {hue=value color=make_color_hsv(hue,sat,val) makergb=1}
            if (text=="sat") {sat=value color=make_color_hsv(hue,sat,val) makergb=1}
            if (text=="val") {val=value color=make_color_hsv(hue,sat,val) makergb=1}
            if (text=="hue%") {hue=round(value/360*255) color=make_color_hsv(hue,sat,val) makergb=1}
            if (text=="sat%") {sat=value color=make_color_hsv(hue,sat,val) makergb=1}
            if (text=="val%") {val=value color=make_color_hsv(hue,sat,val) makergb=1}
        }
        if (makergb) {
            red=color_get_red(color)
            green=color_get_green(color)
            blue=color_get_blue(color)
        }
        if (makehue) {
            if (color!=0 && color!=$ffffff) hue=color_get_hue(color)
            if (color==0) sat=255 else sat=color_get_saturation(color)
            val=color_get_value(color)
        }
    }
}

if (act=="grabwheel") {
    hue=round(point_direction(278+100,10+100,mx,my)/k)
    if (point_distance(278+100,10+100,mx,my)<80) hue=floor(roundto(hue,255/12))
    color=make_color_hsv(hue,sat,val)
    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
    if (!button) act=""
}
if (act="grabprism") {
    cx=mx-(278+100)
    cy=my-(10+100)
    l=point_distance(0,0,cx,cy)
    d=point_direction(0,0,cx,cy)-hue*k+30
    cx=lengthdir_x(l,d)
    cy=lengthdir_y(l,d)
    val=round(clamp((80-cy)/120,0,1)*255)
    if (val=0) sat=255 else sat=round(clamp((cx/lerp(0,120*dtan(30)*2,(val/255)))+0.5,0,1)*255)
    color=make_color_hsv(hue,sat,val)
    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
    if (!button) act=""
}
if (act=="grabred") {
    red=clamp(round(mx-12),0,255)
    if (my>graby) red=roundto(red,16)
    color=make_color_rgb(red,green,blue)
    if (color!=0 && color!=$ffffff) hue=color_get_hue(color)
    if (color==0) sat=255 else sat=color_get_saturation(color)
    val=color_get_value(color)
    if (!button) act=""
}
if (act=="grabgreen") {
    green=clamp(round(mx-12),0,255)
    if (my>graby) green=roundto(green,16)
    color=make_color_rgb(red,green,blue)
    if (color!=0 && color!=$ffffff) hue=color_get_hue(color)
    if (color==0) sat=255 else sat=color_get_saturation(color)
    val=color_get_value(color)
    if (!button) act=""
}
if (act=="grabblue") {
    blue=clamp(round(mx-12),0,255)
    if (my>graby) blue=roundto(blue,16)
    color=make_color_rgb(red,green,blue)
    if (color!=0 && color!=$ffffff) hue=color_get_hue(color)
    if (color==0) sat=255 else sat=color_get_saturation(color)
    val=color_get_value(color)
    if (!button) act=""
}

if (act=="grabhue") {
    hue=clamp(round(mx-12),0,255)
    if (my>graby) hue=roundto(hue,16)
    color=make_color_hsv(hue,sat,val)
    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
    if (!button) act=""
}
if (act=="grabsat") {
    sat=clamp(round(mx-12),0,255)
    if (my>graby) sat=roundto(sat,16)
    color=make_color_hsv(hue,sat,val)
    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
    if (!button) act=""
}
if (act=="grabval") {
    val=clamp(round(mx-12),0,255)
    if (my>graby) val=roundto(val,16)
    color=make_color_hsv(hue,sat,val)
    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
    if (!button) act=""
}
if (act="grabcancel") {
    if (!button) {
        act=""
        if (point_in_rectangle(mx,my,380,328,380+48,328+40)) {
            color=oldcolor
            if (!postundo) pop_undo()
            event_user(0)
            instance_destroy()
            exit
        }
    }
}
if (act="grabok") {
    if (!button) {
        act=""
        if (point_in_rectangle(mx,my,432,328,432+48,328+40)) {
            event_user(0)
            instance_destroy()
            exit
        }
    }
}

event_user(0)

if (customcolor!=noone) customcolors[customcolor]=color
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//the undo logic is kind of a mess because objects and tiles perform undo after,
//and other globals perform undo first. so we have two types of undo models
undo=postundo

if (type=="field")
    target_instance.fields[index,1]="$"+string_hex(color)
if (type=="textfield") {
    with (target_instance) {
        val=other.color
        text=string(val)
        active=1
        textfield_actions()
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color_sel()
draw_rectangle(target_instance.bbox_left,target_instance.bbox_top,target_instance.bbox_right+1,target_instance.bbox_bottom+1,1)
draw_arrow(offx+w/2,offy+h/2,mean(target_instance.bbox_left,target_instance.bbox_right+1),mean(target_instance.bbox_top,target_instance.bbox_bottom+1),11)
draw_set_color($ffffff)

    //draw
    d3d_transform_add_translation(offx,offy,0)
    draw_button_ext(0,0,w,h,1,global.col_main)
    draw_button_ext(0,-32,w,32,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(8,-32+6,title)
    draw_set_color($ffffff)

    //color wheel
    d3d_transform_stack_push()
    d3d_transform_set_identity()
    s=surface_set("colorwheel1",808,808)
        draw_clear(global.col_main)
        d3d_set_projection_ortho(0,0,202,202,0)

        dx=100+0.5
        dy=100+0.5

        //rainbow wheel
        draw_primitive_begin(pr_trianglefan)
            draw_vertex_color(dx,dy,0,1)
            for (i=0;i<=256;i+=1) {
                draw_vertex_color(
                    dx+lengthdir_x(100,i*k),dy+lengthdir_y(100,i*k),
                    make_color_hsv(i,255,255),1
                )
            }
        draw_primitive_end()
        draw_set_circle_precision(12)
        draw_circle_color(dx,dy,80,global.col_main,global.col_main,0)
        draw_line_width(dx,dy,dx+lengthdir_x(100,hue*k),dy+lengthdir_y(100,hue*k),2)

        //prism
        draw_triangle_color(
            dx+lengthdir_x(80,hue*k    ),dy+lengthdir_y(80,hue*k    ),
            dx+lengthdir_x(80,hue*k+120),dy+lengthdir_y(80,hue*k+120),
            dx+lengthdir_x(80,hue*k+240),dy+lengthdir_y(80,hue*k+240),
            make_color_hsv(hue,255,255),$ffffff,0,0
        )

        //color pointer
        cy=80-120*(val/255)
        cx=lerp(0,(sat/255-0.5)*120*dtan(30)*2,(val/255))
        l=point_distance(0,0,cx,cy)
        d=point_direction(0,0,cx,cy)+hue*k-30
        dx+=lengthdir_x(l,d)
        dy+=lengthdir_y(l,d)
        draw_set_circle_precision(16)
        draw_circle(dx,dy,8,0)
        draw_circle_color(dx,dy,6,color,color,0)
        draw_set_circle_precision(8)

        texture_set_interpolation(1)
        s2=surface_set("colorwheel2",404,404)
            draw_surface_ext(s,0,0,0.5,0.5,0,$ffffff,1)
    surface_reset_target()
    d3d_set_projection_ortho(0,0,width,height,0)
    d3d_transform_stack_pop()
    draw_surface_ext(s2,278,10,0.5,0.5,0,$ffffff,1)
    texture_set_interpolation(interpolation)

    draw_set_circle_precision(8)

    for (i=0;i<48;i+=1) {
        draw_button_ext(8+(i mod 8)*33,8+(i div 8)*24,33,24,0,mspal[i])
    }

    for (i=0;i<16;i+=1) {
        draw_button_ext(8+(i mod 8)*33,160+(i div 8)*24,33,24,!(customcolor==i),customcolors[i])
    }


    dy=216
    draw_button_ext(8,dy   ,256+8,24,0,global.col_main) draw_button_ext(256+20,dy   ,40,24,0,pick(text=="red",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy   ,52,24,0,pick(text=="red%",$c0c0c0,$ffffff))
    draw_button_ext(8,dy+24,256+8,24,0,global.col_main) draw_button_ext(256+20,dy+24,40,24,0,pick(text=="green",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy+24,52,24,0,pick(text=="green%",$c0c0c0,$ffffff))
    draw_button_ext(8,dy+48,256+8,24,0,global.col_main) draw_button_ext(256+20,dy+48,40,24,0,pick(text=="blue",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy+48,52,24,0,pick(text=="blue%",$c0c0c0,$ffffff))

    draw_set_color($0000ff) draw_rectangle(12,dy+4,12+red,dy+4+15,0)
    draw_set_color($00ff00) draw_rectangle(12,dy+4+24,12+green,dy+4+24+15,0)
    draw_set_color($ff0000) draw_rectangle(12,dy+4+48,12+blue,dy+4+48+15,0)

    dx=12
    draw_set_color(global.col_low)
    i=1 repeat (15) {
        draw_line(dx+i*16,dy+16,dx+i*16,dy+19)
        draw_line(dx+i*16,dy+16+24,dx+i*16,dy+19+24)
        draw_line(dx+i*16,dy+16+48,dx+i*16,dy+19+48)
    i+=1}
    draw_set_color($ffffff)

    dy=296
    draw_button_ext(8,dy   ,256+8,24,0,global.col_main) draw_button_ext(256+20,dy   ,40,24,0,pick(text=="hue",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy   ,52,24,0,pick(text=="hue%",$c0c0c0,$ffffff))
    draw_button_ext(8,dy+24,256+8,24,0,global.col_main) draw_button_ext(256+20,dy+24,40,24,0,pick(text=="sat",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy+24,52,24,0,pick(text=="sat%",$c0c0c0,$ffffff))
    draw_button_ext(8,dy+48,256+8,24,0,global.col_main) draw_button_ext(256+20,dy+48,40,24,0,pick(text=="val",$c0c0c0,$ffffff)) draw_button_ext(256+64,dy+48,52,24,0,pick(text=="val%",$c0c0c0,$ffffff))

    draw_set_color(make_color_hsv(hue,255,255)) draw_rectangle(12,dy+4,12+hue,dy+4+15,0) draw_set_color($ffffff)
    draw_rectangle_color(12,dy+4+24,12+sat,dy+4+24+15,$ffffff,color,color,$ffffff,0)
    draw_rectangle_color(12,dy+4+48,12+val,dy+4+48+15,0,color,color,0,0)

    dx=12
    draw_set_color(global.col_low)
    i=1 repeat (15) {
        draw_line(dx+i*16,dy+16,dx+i*16,dy+19)
        draw_line(dx+i*16,dy+16+24,dx+i*16,dy+19+24)
        draw_line(dx+i*16,dy+16+48,dx+i*16,dy+19+48)
    i+=1}
    draw_set_color($ffffff)

    dy=376

    draw_button_ext(380,296,100,24,0,pick(text=="hex",$c0c0c0,$ffffff))

    col=string_hex(color)
    col="$"+string_repeat("0",6-string_length(col))+col

    draw_set_color(0)
    draw_text(380+14,296+2,col)

    dy=216+2
    draw_text(14,dy   ,"Red"       )
    draw_text(14,dy+24,"Green"     )
    draw_text(14,dy+48,"Blue"      )
    draw_text(256+25,dy   ,red  ) draw_text(256+69,dy   ,string(round(red/2.55  ))+"%")
    draw_text(256+25,dy+24,green) draw_text(256+69,dy+24,string(round(green/2.55))+"%")
    draw_text(256+25,dy+48,blue ) draw_text(256+69,dy+48,string(round(blue/2.55 ))+"%")

    dy=296+2
    draw_text(14,dy   ,"Hue"       )
    draw_text(256+25,dy   ,hue  ) draw_text(256+69,dy   ,string(round(hue/255*360))+"º")
    draw_text(14,dy+24,"Saturation")
    draw_text(256+25,dy+24,sat  ) draw_text(256+69,dy+24,string(round(sat/2.55   ))+"%")
    draw_text(256+25,dy+48,val  ) draw_text(256+69,dy+48,string(round(val/2.55   ))+"%")

    draw_set_color($ffffff)

    dy=296+2
    draw_text(14,dy+48,"Value"     )

    dx=380 dy=328 draw_button_ext(dx,dy,48,40,act!="grabcancel",global.col_main) draw_sprite(sprMenuButtons,25,dx+24,dy+20)
    dx=432 dy=328 draw_button_ext(dx,dy,48,40,act!="grabok",global.col_main) draw_sprite(sprMenuButtons,0,dx+24,dy+20)

    draw_button_ext(380,216,48,72,0,oldcolor)
    draw_button_ext(432,216,48,72,0,color)
    draw_sprite(sprMenuButtons,30,430,252)

    d3d_transform_set_identity()
