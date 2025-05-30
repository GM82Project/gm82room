///draw_button_ext(x,y,w,h,up,color)
var dx,dy,w,h,up,col,u,v,down,spr;

dx=argument0
dy=argument1
w=argument2
h=argument3

up=argument4
col=argument5

if (col!=noone) {
    /*
    code for experimental texture mode

    texture_set_repeat(1)
    draw_primitive_begin_texture(pr_trianglestrip,background_get_texture(background5))
    draw_vertex_texture_color(dx,dy,dx/48,dy/48,col,1)
    draw_vertex_texture_color(dx+w,dy,(dx+w)/48,(dy/48),col,1)
    draw_vertex_texture_color(dx,dy+h,dx/48,(dy+h)/48,col,1)
    draw_vertex_texture_color(dx+w,dy+h,(dx+w)/48,(dy+h)/48,col,1)
    draw_primitive_end()         */

    draw_sprite_ext(spr1x1,0,dx,dy,w,h,0,col,1)
}

down=!up*2

draw_sprite_part(buttontex,down,0,0,4,4,dx,dy)
draw_sprite_part(buttontex,down,76,0,4,4,dx+w-4,dy)
draw_sprite_part(buttontex,down,0,21,4,4,dx,dy+h-4)
draw_sprite_part(buttontex,down,76,21,4,4,dx+w-4,dy+h-4)

draw_sprite_part_ext(buttontex,down,5,0,70,4,dx+4,dy,(w-8)/70,1,$ffffff,1)
draw_sprite_part_ext(buttontex,down,5,21,70,4,dx+4,dy+h-4,(w-8)/70,1,$ffffff,1)
draw_sprite_part_ext(buttontex,down,0,5,4,15,dx,dy+4,1,(h-8)/15,$ffffff,1)
draw_sprite_part_ext(buttontex,down,76,5,4,15,dx+w-4,dy+4,1,(h-8)/15,$ffffff,1)
