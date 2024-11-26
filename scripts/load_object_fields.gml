///load_object_fields(object,objname)
//scan an object's event code for field declarations

//i know this looks kind of nasty but we need to consider speed here, as this
//can potentially read through thousands of lines of gml when loading a room
//so it's been written for speed in most places

var i,f,reading,str,p,linec,actionc,line,fp,action,temp,previousindent,parent,fieldparent,stack,fail;

i=argument0

objnodrawself[i]=false

previousindent=1
fieldparent=noone
stack=ds_stack_create()

objprev=""
reading=0
actionc=0
linec=0
f=file_text_open_read_safe(root+"objects\"+argument1+".gml") if (f) {do {
    line=file_text_read_string(f)
    file_text_readln(f) linec+=1
    str=line
    if (!reading) {
        if (string_pos("#define Other_4",str)) {
            //only look for fields in room start events
            reading=1
            linec=-5
            actionc=0
        }
    } else {
        //expect end of room start event
        if (string_pos("#define",str)) {
            reading=0 break
        }

        //expect drag and drop action header
        if (string_pos("/*"+qt+"/*'/**//*",str)) {
            actionc+=1
            //jump to where the action id is
            file_text_readln(f)
            action=file_text_read_string(f)
            //look for "event inherited" action
            if (string_pos("action_id=604",action)) {
                parent=get_object_parent(argument1)
                if (parent!="") load_object_fields(i,parent)
            }
            //look for gm82 "inherit object" action
            if (string_pos("action_id=902",action)) {
                //scroll down to argument 0
                file_text_readln(f)
                file_text_readln(f)
                file_text_readln(f)
                parent=string_delete(file_text_read_string(f),1,5) //erase "arg0="
                if (parent!="") load_object_fields(i,parent)
            }

            //look for a code action
            if (string_pos("action_id=603",action)) {
                //skip the rest of the action header
                do {file_text_readln(f) str=file_text_read_string(f)} until (str=="*/" || file_text_eof(f))
                linec=-1
            } else continue
        }

        temp=string_replace_all(str," ","")

        //expect field inheritance
        if (string_pos("event_inherited()",temp)) {
            parent=get_object_parent(argument1)
            if (parent!="") load_object_fields(i,parent)
        }

        //expect field object inheritance
        p=string_pos("event_inherit_object(",temp)
        if (p) {
            temp=string_delete(temp,1,p+20)
            parent=string_copy(temp,1,string_pos(")",temp)-1)
            if (parent!="") load_object_fields(i,parent)
        }

        //expect description field
        fp=string_pos("/*desc",str)
        if (fp) {
            while (1) {
                str=file_text_read_string(f)
                file_text_readln(f) linec+=1
                if (string_pos("*/",str) || file_text_eof(f)) break
                //delete indentation
                if (str!="") {
                    p=1 while (string_char_at(str,p)==" ") do p+=1
                    objdesc[i]+=string_delete(str,1,p-1)+lf
                }
            }
            objdesc[i]=string_copy(objdesc[i],1,string_length(objdesc[i])-1)
        }

        //all the errors start with this so we cache it now
        errorh="Error in action "+string(actionc)+" of Room Start event for object "+qt+argument1+qt+":"+crlf+crlf

        //expect preview field
        fp=string_pos("/*preview",str)
        if (fp) {
            if (string_pos("nodrawself",str)) objnodrawself[i]=true
            fail=false
            while (1) {
                str=file_text_read_string(f)
                file_text_readln(f) linec+=1
                error=errorh+string(linec)+" | "+str+crlf+crlf
                if (string_pos("*/",str)) break
                if (str!="") {
                    //look for constants
                    alphanumleft="abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    alphanumright=alphanumleft+"0123456789"

                    key=ds_map_find_first(constmap) repeat (constmapsize) {
                        p=string_pos(key,str)
                        if (p) {
                            //if constant is a whole token
                            if (!string_pos(alphanumleft,string_char_at(str,p-1)))
                            and (!string_pos(alphanumright,string_char_at(str,p+string_length(key)))) {
                                //check if constant doesn't contain a function call
                                if (ds_map_exists(consthasfunc,key)) {
                                    show_message(error+"Constant '"+key+"' present in preview field appears to have a function call in it, and can't be used in a preview field.")
                                    objprev=""
                                    //skip rest of preview field and exit loader
                                    fail=true
                                    break
                                } else {
                                    //instantiate constant
                                    str=string_replace_all(str,key,"("+ds_map_find_value(constmap,key)+")")
                                }
                            }
                        }
                    key=ds_map_find_next(constmap,key)}
                    
                    if (fail) break
                    objprev+=str+crlf                    
                }
            }
        }

        //expect field
        fp=string_pos("//field ",str)
        if (fp) {
            //found a field signature; parse it
            
            error=errorh+string(linec)+" | "+line+crlf+crlf
            if (fp>previousindent) {
                //field is more indented, store previous field dependency parent
                repeat (fp-previousindent) ds_stack_push(stack,fieldparent)
                fieldparent=objfields[i]-1
            }
            if (fp<previousindent) {
                //deindent; restore old parent
                repeat (previousindent-fp) fieldparent=ds_stack_pop(stack)
            }
            objfielddepends[i,objfields[i]]=fieldparent
            objfieldindent[i,objfields[i]]=fp-1
            previousindent=fp

            //find annotations
            objfielddef[i,objfields[i]]=""
            p=string_length(str)-3
            repeat (p) {
                if (string_copy(str,p,3)==" - ") break
            p-=1}

            if (p) {
                objfielddef[i,objfields[i]]=" - "+string_delete_edge_spaces(string_delete(str,1,p+2))
                str=string_delete_edge_spaces(string_copy(str,1,p-1))
            }

            p=string_pos(": ",str)
            if (p) {
                fieldname=string_delete_edge_spaces(string_copy(str,fp+8,p-(fp+8)))
                if (invalid_variable_name(fieldname)) {
                    show_message(error+"Field name "+qt+fieldname+qt+" contains invalid characters.")
                } else {
                    objfieldname[i,objfields[i]]=fieldname
                    str=string_delete_edge_spaces(string_delete(str,1,p+1))

                    if (string_pos("enum",str)) {
                        //enums are parsed differently due to option list
                        if (string_count("(",str)==1 && string_count(")",str)==1 && string_pos("(",str)<string_pos(")",str)) {
                            objfieldtype[i,objfields[i]]="enum"
                            //get the enum list from within the ()'s
                            str=string_delete(string_copy(str,1,string_pos(")",str)-1),1,string_pos("(",str))
                            if (str="") {
                                show_message(error+"Enum declaration has empty option list.")
                            } else {
                                objfieldargs[i,objfields[i]]=string_delete_edge_spaces(str)
                                objfields[i]+=1
                            }
                        } else {
                            show_message(error+"Enum declaration missing list of options in parenthesis.")
                        }
                    } else if (string_pos("number",str)) {
                        //numbers are parsed differently due to range list
                        if (string_count("(",str)==1 && string_count(")",str)==1 && string_pos("(",str)<string_pos(")",str)) {
                            objfieldtype[i,objfields[i]]="number_range"
                            //get the range from within the ()'s
                            str=string_delete(string_copy(str,1,string_pos(")",str)-1),1,string_pos("(",str))
                            if (str="") {
                                show_message(error+"Number declaration has empty range.")
                            } else {
                                string_token_start(str,",")
                                __left=string_number(string_token_next())
                                __right=string_number(string_token_next())

                                if (__left=="" || __right=="") {
                                    show_message(error+"Number declaration has invalid range:#"+str)
                                } else {
                                    objfieldargs[i,objfields[i]]=__left+","+__right
                                    objfields[i]+=1
                                }
                            }
                        } else {
                            objfieldtype[i,objfields[i]]="number"
                            objfields[i]+=1
                        }
                    } else {
                        if (invalid_field_type(str)) {
                            show_message(error+"Field type "+qt+str+qt+" is not recognized.")
                        } else {
                            objfieldtype[i,objfields[i]]=str
                            objfields[i]+=1
                        }
                    }
                }
            } else {
                //default to "value" type when no type is present
                fieldname=string_delete_edge_spaces(string_delete(str,1,fp+7))
                if (invalid_variable_name(fieldname)) {
                    show_message(error+"Field name "+qt+fieldname+qt+" contains invalid characters.")
                } else {
                    objfieldname[i,objfields[i]]=fieldname
                    objfieldtype[i,objfields[i]]="value"
                    objfields[i]+=1
                }
            }
        }
    }
} until (file_text_eof(f)) file_text_close(f)
    //compile field preview code

    if (objprev!="") {
        check=string_antivirus(objprev)
        if (check="size limit") show_message("Error compiling object preview field for "+argument1+":##Preview code is too big. Keep it to 8192 characters.")
        else if (check!="") show_message("Error compiling object preview field for "+argument1+":##Forbidden word detected "+qt+check+qt)
        else {
            fieldshim=""
            for (j=0;j<objfields[i];j+=1) {
                if (objfieldtype[i,j]=="font") fieldshim+=objfieldname[i,j]+"=Font(Field('"+objfieldname[i,j]+"'))"+crlf
                else if (objfieldtype[i,j]=="sprite") fieldshim+=objfieldname[i,j]+"=Sprite(Field('"+objfieldname[i,j]+"'))"+crlf
                else if (objfieldtype[i,j]=="xy") fieldshim+=objfieldname[i,j]+"[0]=Field('"+objfieldname[i,j]+"',0) "+objfieldname[i,j]+"[1]=Field('"+objfieldname[i,j]+"',1) "+crlf
                else fieldshim+=objfieldname[i,j]+"=Field('"+objfieldname[i,j]+"')"+crlf
            }

            object_event_add(objprev_curobj,ev_other,ev_user0+objprev_curevent,fieldshim+objprev)
            if (error_occurred) show_message("Error compiling object preview field for "+argument1+":##"+error_last)
            objprev_objectid[i]=objprev_curobj
            objprev_eventid[i]=objprev_curevent

            objprev_curevent+=1
            if (objprev_curevent==16) {
                objprev_curobj=object_add()
                objprev_curevent=0
            }
        }
    }
}

ds_stack_destroy(stack)

//load parent's fields if there was no room start event
if (actionc==0) {
    parent=get_object_parent(argument1)
    if (parent!="") load_object_fields(i,parent)
}
