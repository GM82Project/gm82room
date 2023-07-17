///load_jmap()
//loads a jmap file and converts it into engine objects
var fn,f,str,sx,sy,st,name,o,spr;

fn=get_open_filename("jtool map|*.jmap","")

if (file_exists(fn)) {
    f=file_text_open_read(fn)
    str=file_text_read_string(f) file_text_readln(f)
    if (string_pos("jtool",str)==1) {
        repeat (16) {
            str=file_text_read_string(f) file_text_readln(f)
            if (string_pos("objects:",str)==1) {
                if (!has_jtool_table) {
                    //engine has no jtool table, let's figure out which engine this is
                    engine="yoyoyo"
                    if (ds_list_find_index(objects,"World")+1) {
                        get_object("World")
                        spr=ds_map_find_value(object[objpal],"sprite")
                        if (spr=="sprController") engine="renex"
                        else if (spr=="sprWorld") engine="verve"
                    } else if (!(ds_list_find_index(objects,"objMiniBlock")+1)) engine="nane"                          
                    load_jtooldata(engine)
                } else engine=jtool_loaded_engine

                if (!load_all_jtool_objs()) {
                    show_message("Some engine objects weren't found. Instances may be missing.")
                }

                //phew
                deselect()
                do {
                    sx=file_text_read_real(f)
                    sy=file_text_read_real(f)
                    st=file_text_read_real(f)
                    name=ds_map_find_value(jtool_objs,st)
                    if string(name)=="0" show_message(st)
                    if (get_object(name)!=noone) {
                        o=instance_create(sx,sy,instance) get_uid(o)
                        o.obj=objpal
                        o.objname=name
                        o.depth=objdepth[o.obj]
                        o.sprite_index=objspr[o.obj]
                        o.sprw=sprite_get_width(o.sprite_index)
                        o.sprh=sprite_get_height(o.sprite_index)
                        o.sprox=sprite_get_xoffset(o.sprite_index)
                        o.sproy=sprite_get_yoffset(o.sprite_index)
                        if (engine=="nane" && st==2) {
                            //nane gm8 doesnt have miniblocks
                            o.image_xscale=0.5
                            o.image_yscale=0.5
                        }
                        if ((engine=="renex" || engine=="verve") && st==26) {
                            //modern engines don't have flipped saves
                            o.image_angle=180
                        }         
                        if (st==27) {
                            //no engine has mini killer blocks
                            o.image_xscale=0.5
                            o.image_yscale=0.5
                        }
                        parse_code_into_fields(o,1)
                        o.sel=1
                        o.modified=1
                    }
                } until file_text_eoln(f)
                begin_undo(act_destroy,"loaded jmap",0)
                with (instance) if (modified) {add_undo(uid) modified=0}
                push_undo()
                update_inspector()
                selection=true
                update_selection_bounds()
                update_instance_memory()
                file_text_close(f)
                return 1
            }
        }
        show_message("Couldn't find jmap object data. Possibly not a jtool map?")
    } else show_message("This doesn't seem to be a jtool map...")
    file_text_close(f)
}
return 0
