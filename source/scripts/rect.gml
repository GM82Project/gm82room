///rect(x,y,w,h,col,alpha)
draw_sprite_ext(spr1x1,0,argument0,argument1,argument2,argument3,0,argument4,argument5)

/*
code for experimental texture mode

var dx,dy,w,h,col,a;
dx=argument0
dy=argument1
w=argument2
h=argument3
col=argument4
a=argument5

texture_set_repeat(1)
draw_primitive_begin_texture(pr_trianglestrip,background_get_texture(background5))
draw_vertex_texture_color(dx,dy,dx/48,dy/48,col,a)
draw_vertex_texture_color(dx+w,dy,(dx+w)/48,(dy/48),col,a)
draw_vertex_texture_color(dx,dy+h,dx/48,(dy+h)/48,col,a)
draw_vertex_texture_color(dx+w,dy+h,(dx+w)/48,(dy+h)/48,col,a)
draw_primitive_end()
*/
