var str,tf,f;

rect(0,0,width,height,0,0.5)
draw_button(width/2-170,height/2-50,340,100,1)
draw_set_halign(1)
draw_set_valign(1)
draw_text(width/2,height/2,"External code editor open##close the editor to continue")
draw_set_halign(0)
draw_set_valign(0)
screen_refresh()

str=argument0

tf=temp_directory+"\code.txt"

f=file_text_open_write(tf)
file_text_write_string(f,string_replace_all(str,chr(10),chr(13)+chr(10)))
file_text_close(f)

execute_program(codeeditor,tf,1)

if (file_exists(tf)) {
    str=string_replace_all(file_text_read_all(tf),chr(13),"")
    if (string_replace_all(string_replace_all(string_replace_all(str,chr(9),""),chr(10),"")," ","")="") str=""
    return str
}

return argument0