var p1,p2;

p1=1
p2=string_length(argument0)

while (string_char_at(argument0,p1)==" " && p1<p2) p1+=1
while (string_char_at(argument0,p2)==" " && p2>0) p2-=1

return string_copy(argument0,p1,p2-p1+1)
