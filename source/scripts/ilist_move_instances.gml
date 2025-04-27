///ilist_move_instances(direction)
var sorted,i,o;

with (Instancepanel) {
    sorted=false

    if (argument0==1) {
        i=length-1 repeat (i-1) {
            if (inst[i-1].sel and !inst[i].sel and inst[i-1].depth==inst[i].depth) {
                o=inst[i].order inst[i].order=inst[i-1].order inst[i-1].order=o
                o=inst[i]       inst[i]      =inst[i-1]       inst[i-1]      =o
                sorted=true
            }
        i-=1}
    }

    if (argument0==-1) {
        i=0 repeat (length-1) {
            if (inst[i+1].sel and !inst[i].sel and inst[i+1].depth==inst[i].depth) {
                o=inst[i].order inst[i].order=inst[i+1].order inst[i+1].order=o
                o=inst[i]       inst[i]      =inst[i+1]       inst[i+1]      =o
                sorted=true
            }
        i+=1}
    }

    if (sorted) {
        update_scheduled=true
        return true
    }

    if (argument0== 2) while (ilist_move_instances( 1)){}
    if (argument0==-2) while (ilist_move_instances(-1)){}
}

return false
