fontmap=dsmap()

f=file_text_open_read_safe(root+"fonts\index.yyd") if (f) {do {fontname=file_text_read_string(f) file_text_readln(f) if (fontname!="") {
    f2=file_text_open_read_safe(root+"fonts\"+fontname+".txt") if (f2) {
        name=file_text_read_string(f2) file_text_readln(f2) name=string_delete(name,1,string_pos("=",name))
        size=file_text_read_string(f2) file_text_readln(f2) size=real(string_delete(size,1,string_pos("=",size)))
        bold=file_text_read_string(f2) file_text_readln(f2) bold=real(string_delete(bold,1,string_pos("=",bold)))
        italic=file_text_read_string(f2) file_text_readln(f2) italic=real(string_delete(italic,1,string_pos("=",italic)))
        file_text_readln(f2)//charset
        file_text_readln(f2)//aa
        first=file_text_read_string(f2) file_text_readln(f2) first=real(string_delete(first,1,string_pos("=",first)))
        last=file_text_read_string(f2) file_text_readln(f2) last=real(string_delete(last,1,string_pos("=",last)))
        dsmap(fontmap,fontname,font_add(name,size,bold,italic,first,last))
    }file_text_close(f2)
}} until (file_text_eof(f)) file_text_close(f)}
