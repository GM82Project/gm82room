///set_autotiler_mode([smart])
//no args = toggle
var mode;

if (argument_count) mode=argument[0] else mode=(bg_tilemode[tilebgpal]<0)

if (mode) {
    bg_tilemode[tilebgpal]=max(1,abs(bg_tilemode[tilebgpal]))
    bg_modified[tilebgpal]=true
    clear_inspector()
    deselect()
} else {
    bg_tilemode[tilebgpal]=-abs(bg_tilemode[tilebgpal])
    bg_modified[tilebgpal]=true
}
