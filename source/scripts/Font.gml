///Font(name)
var f2,name,size,bold,italic,first,last,font;

if (is_undefined(argument0)) return -1

if (!ds_map_exists(fontmap,argument0)) {
    if (has_fonts) {
        f2=file_text_open_read_safe(root+"fonts\"+argument0+".txt") if (f2) {
            name=file_text_read_string(f2) file_text_readln(f2) name=string_delete(name,1,string_pos("=",name))
            size=file_text_read_string(f2) file_text_readln(f2) size=real(string_delete(size,1,string_pos("=",size)))
            bold=file_text_read_string(f2) file_text_readln(f2) bold=real(string_delete(bold,1,string_pos("=",bold)))
            italic=file_text_read_string(f2) file_text_readln(f2) italic=real(string_delete(italic,1,string_pos("=",italic)))
            file_text_readln(f2)//charset
            file_text_readln(f2)//aa
            first=file_text_read_string(f2) file_text_readln(f2) first=real(string_delete(first,1,string_pos("=",first)))
            last=file_text_read_string(f2) file_text_readln(f2) last=real(string_delete(last,1,string_pos("=",last)))
            font=font_add(name,size,bold,italic,first,last)
            dsmap(fontmap,argument0,font)
        }file_text_close(f2)
        return font
    }
    else return -1
}

return dsmap(fontmap,argument0)
