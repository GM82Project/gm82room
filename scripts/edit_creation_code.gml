var str,tf,f;

tf=temp_directory+"\code.txt"

str=""
if (num_selected()==1) with (instance) if (sel) str=code

f=file_text_open_write(tf)
file_text_write_string(f,string_replace_all(str,chr(10),chr(13)+chr(10)))
file_text_close(f)

execute_program(codeeditor,tf,1)

if (file_exists(tf)) {
    str=string_replace_all(file_text_read_all(tf),chr(13)+chr(10),chr(10))
    with (instance) if (sel) code=str
}
