#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
w=200
h=100
open=0
grab=0
scroll=0

length=0
showlength=0
updatew=0
update_scheduled=true
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
update_scheduled=false

ds_priority_clear(click_priority)
with (instance) ds_priority_add(click_priority,id,-depth+order/orderlast)

length=ds_priority_size(click_priority)
showlength=min(length,floor((h-148-8)/20))
scroll=min(scroll,max(0,length-showlength))

i=0 repeat (length) {
    o=ds_priority_delete_min(click_priority)
    inst[i]=o
    sprite[i]=objspr[o.obj]
    name[i]=o.objname+" ("+string(o.x)+","+string(o.y)+") ["+o.uid+"]"
    if (updatew) w=max(w,8+20+string_width(name[i])+8)
i+=1}

updatew=0
