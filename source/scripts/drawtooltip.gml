///drawtooltip(str)
var w,h,str,l;

str=argument0

l=string_length(str)
if (string_char_at(str,l)==lf) str=string_copy(str,1,l-1)

str=string_replace_all(str,lf,crlf)

w=string_width_ext(str,-1,width*0.5)+8
h=string_height_ext(str,-1,width*0.5)+8

x1=median(0,mouse_wx,width-w)
y1=median(0,mouse_wy+32,height-h)+tty

if (y1+h==height) y1=mouse_wy-h-16

draw_rectangle_color(x1,y1,x1+w,y1+h,$ddffff,$ddffff,$ddffff,$ddffff,0)
draw_rectangle_color(x1,y1,x1+w,y1+h,0,0,0,0,1)
draw_text_ext_color(x1+4,y1+4,str,-1,width*0.5,0,0,0,0,1)

tty+=h+8
