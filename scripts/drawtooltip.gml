///drawtooltip(str)
var w,h;

w=string_width(argument0)+8
h=string_height(argument0)+8

x1=median(0,mouse_wx,width-w)
y1=median(0,mouse_wy+24,height-h)
draw_rectangle_color(x1,y1,x1+w,y1+h,$ddffff,$ddffff,$ddffff,$ddffff,0)
draw_rectangle_color(x1,y1,x1+w,y1+h,0,0,0,0,1)
draw_text_color(x1+4,y1+4,argument0,0,0,0,0,1)
