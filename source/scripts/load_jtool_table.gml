//loads a jtool table from an engine script
var fn,str,f,p;

fn=root+"scripts\"+argument0+".gml"

if (file_exists(fn)) {
    f=file_text_open_read(fn)

    jtool_loaded_engine="MISSING"

    while (!file_text_eof(f)) {
        str=file_text_read_string(f)
        file_text_readln(f)

        p=string_pos("=",str)
        if (p) {
            index=string_copy(str,1,p-1)
            name=string_delete(str,1,p)

            if (string_pos("engine",index)) {jtool_loaded_engine=name continue}

            ds_map_add(jtool_objs,real(index),name)
        }
    }
    file_text_close(f)

    if (ds_map_size(jtool_objs)>=27)
        has_jtool_table=true
    else {
        show_message("This engine's jtool table seems to be formatted incorrectly.##Engine identifier: "+jtool_loaded_engine+"##At least 27 object entries are expected. Found this:##"+dsmap(jtool_objs))
        jtool_loaded_engine="yoyoyo"
    }
}
