///point_in_quad(px,py,x1,y1,x2,y2,x3,y3,x4,y4)
var px,py,x1,y1,x2,y2,x3,y3,x4,y4;

px=argument0
py=argument1
x1=argument2
y1=argument3
x2=argument4
y2=argument5
x3=argument6
y3=argument7
x4=argument8
y4=argument9

return (point_in_triangle(px,py,x1,y1,x2,y2,x3,y3) || point_in_triangle(px,py,x1,y1,x3,y3,x4,y4))
