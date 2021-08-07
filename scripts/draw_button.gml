///draw_button(x,y,w,h,up)
var dx,dy,w,h,up,col1,col2,col3;

dx=argument0
dy=argument1
w=argument2
h=argument3

up=argument4

if (up) {col1=global.col_high col2=global.col_low}
else {col1=global.col_low col2=global.col_high}
col3=buttoncol

buttoncol=global.col_main

draw_primitive_begin(pr_trianglelist)
    //bg
    draw_vertex_color(dx,dy,col2,1)
    draw_vertex_color(dx+w,dy,col2,1)
    draw_vertex_color(dx,dy+h,col2,1)

    draw_vertex_color(dx,dy+h,col2,1)
    draw_vertex_color(dx+w,dy,col2,1)
    draw_vertex_color(dx+w,dy+h,col2,1)

    //highlight
    draw_vertex_color(dx,dy,col1,1)
    draw_vertex_color(dx+w,dy,col1,1)
    draw_vertex_color(dx+w-8,dy+8,col1,1)

    draw_vertex_color(dx,dy,col1,1)
    draw_vertex_color(dx,dy+h,col1,1)
    draw_vertex_color(dx+8,dy+h-8,col1,1)

    draw_vertex_color(dx,dy,col1,1)
    draw_vertex_color(dx+8,dy+h-8,col1,1)
    draw_vertex_color(dx+w-8,dy+8,col1,1)

    //middle
    draw_vertex_color(dx+4,dy+4,col3,1)
    draw_vertex_color(dx+w-4,dy+4,col3,1)
    draw_vertex_color(dx+4,dy+h-4,col3,1)

    draw_vertex_color(dx+4,dy+h-4,col3,1)
    draw_vertex_color(dx+w-4,dy+4,col3,1)
    draw_vertex_color(dx+w-4,dy+h-4,col3,1)
draw_primitive_end()
