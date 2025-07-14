///draw_quad_outline(x1,y1,x2,y2,x3,y3,x4,y4)
var x1,y1,x2,y2,x3,y3,x4,y4;

x1=argument0
y1=argument1
x2=argument2
y2=argument3
x3=argument4
y3=argument5
x4=argument6
y4=argument7

draw_line(x1,y1,x2,y2)
draw_line(x2,y2,x3,y3)
draw_line(x3,y3,x4,y4)
draw_line(x4,y4,x1,y1)
