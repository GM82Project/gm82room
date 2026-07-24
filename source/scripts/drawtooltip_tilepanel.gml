///drawtooltip_tilepanel(str)
var w,h,str,l;

str=argument0

l=string_length(str)
if (string_char_at(str,l)==lf) str=string_copy(str,1,l-1)

str=string_replace_all(str,lf,crlf)

w=string_width(str)+8
h=string_height(str)+8

x1=Tilepanel.clickx
y1=Tilepanel.clicky+32

draw_rectangle_color(x1,y1,x1+w,y1+h,$ddffff,$ddffff,$ddffff,$ddffff,0)
draw_rectangle_color(x1,y1,x1+w,y1+h,0,0,0,0,1)
draw_text_1color(x1+4,y1+4,str,0,1)
