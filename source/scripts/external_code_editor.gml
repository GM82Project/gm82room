var str,tf,f;

if (codeeditortype==1) {
    return get_string("Code:",argument0)
}

rect(0,0,width,height,0,0.5)

str=argument0

tf=temp_directory+"\code.txt"

f=file_text_open_write(tf)
file_text_write_string(f,string_replace_all(str,lf,chr(13)+lf))
file_text_close(f)

if (codeeditortype==2) execute_program_async("notepad "+tf)
else execute_program_async(codeeditor+" "+tf)

while (execute_program_async_result()==execute_running) {
    //iunno draw a spinner
    draw_button_ext(width/2-170,height/2-50,340,100,1,global.col_main)
    draw_set_halign(1)
    draw_set_valign(1)
    draw_set_color(global.col_text)
    draw_text(width/2,height/2,"External code editor open##close the editor to continue")
    draw_set_color($ffffff)
    draw_set_halign(0)
    draw_set_valign(0)
    screen_refresh()
    sleep(100)
}

if (file_exists(tf)) {
    str=file_text_read_all(tf,lf)
    if (string_replace_all(string_replace_all(string_replace_all(str,chr(9),""),lf,"")," ","")="") str=""
    return str
}

return argument0
