///load_jmap()
//loads a jmap file and converts it into engine objects
var fn,f,str,sx,sy,st,name,o;

fn=get_open_filename("jtool map|*.jmap","")

if (file_exists(fn)) {
    f=file_text_open_read(fn)
    str=file_text_read_string(f) file_text_readln(f)
    if (string_pos("jtool",str)==1) {
        repeat (16) {
            str=file_text_read_string(f) file_text_readln(f)
            if (string_pos("objects:",str)==1) {
                if (!load_all_jtool_objs()) {
                    if (!show_question("Some necessary engine objects weren't found.##Load jmap anyway?")) {
                       file_text_close(f)
                       return 0
                    }
                    //note: should probably just skip any missing objects instead of checking
                        //how to implement with the least amount of file io?
                }

                //phew
                deselect()
                do {
                    sx=file_text_read_real(f)
                    sy=file_text_read_real(f)
                    st=file_text_read_real(f)
                    name=ds_map_find_value(jtool_objs,st)
                    get_object(name) //note: this will crash!! need to implement case for non existent objects
                    {
                        o=instance_create(sx,sy,instance) get_uid(o)
                        o.obj=objpal
                        o.objname=name
                        o.sprite_index=objspr[o.obj]
                        o.sprw=sprite_get_width(o.sprite_index)
                        o.sprh=sprite_get_height(o.sprite_index)
                        o.sprox=sprite_get_xoffset(o.sprite_index)
                        o.sproy=sprite_get_yoffset(o.sprite_index)
                        select=o
                        o.sel=1
                        o.modified=1
                        //with (o) update_inspector()
                    }
                } until file_text_eoln(f)
                begin_undo(act_destroy,"loaded jmap",0)
                with (instance) if (modified) {add_undo(uid) modified=0}
                push_undo()
                update_inspector()
                selection=true
                update_selection_bounds()
                file_text_close(f)
                return 1
            }
        }
        show_message("Couldn't find jmap object data. Possibly not a jtool map?")
    } else show_message("This doesn't seem to be a jtool map...")
    file_text_close(f)
}
return 0
