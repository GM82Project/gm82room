//copy all selected object ids to clipboard
//called by instance list
var i,o,str;

with (Instancepanel) {
    str=""
    i=0 repeat (length) {
        o=inst[i]
        if (o.sel) {
            str+=o.objname+" at ("+string(o.x)+","+string(o.y)+"): "+roomname+"_"+o.uid+crlf
        }
    i+=1}
}
if (str!="") clipboard_set_text(str)
