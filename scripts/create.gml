globalvars()

draw_set_font(fntCode)
draw_set_circle_precision(8)

message_caption(1,"Message")
message_size(500,-1)

width=display_get_width()-80-64
height=display_get_height()-80-64
maxfps=display_get_frequency()

room_speed=maxfps
room_caption="Game Maker 8.2 Room Editor"

autosave_timer=current_time
autosave_interval=5*60*1000 //5 minute autosave in ms

global.livesock=noone

xgo=0
ygo=0
zooming=0
zoom=1
mousein=0
zoomcenter=0
resizecount=0
objpal=noone
tilebgpal=noone
tilebgname=""
curtile=noone
tilepal=0
palettescroll=0
palettescrollgo=0
palettesize=0
layerscroll=0
layerscrollgo=0
layersize=0
tpalscrollgo=0
tpalscroll=0
tpalsize=0
paint=0
erasing=0
overlap_check=1
tile_overlap_check=1
copymode=-1
copyvec[0,0]=0
paladdbuttondown=0
select=noone
selectt=noone
selecting=0
mode=0
grabview=0
sizeview=0
bg_current=0
vw_current=0
ly_current=0
icon_mode=0
focus=noone
window_focused=false

searchresults=ds_list_create()
searchmenu=N_Menu_CreatePopupMenu()
searchmenuitems=ds_map_create()

click_priority=ds_priority_create()

knobz=0
knobzgo=1

undo_initialize()

read_preferences()

load_theme()
load_palette()

jtool_objs=ds_map_create()
thumbmap=ds_map_create()
thumbcount=0

state="load"
crc_init()
if (!load_room()) exit
update_instance_memory()
state="run"

if (!seen) show_info()

view[0]=1 //objects
view[1]=1 //tiles
view[2]=1 //bgs
view[3]=1 //fgs
view[4]=0 //views
view[5]=1 //invisibles
view[6]=1 //nosprites
view[7]=1 //paths

chunkwidth=roomwidth
chunkheight=roomheight
roomleft=0
roomtop=0

//adjust window to fit room
width=max(min_width,min(width,roomwidth+64+160*2))
height=max(min_height,min(height,roomheight+64+64))
xgo=roomwidth/2 ygo=roomheight/2
zoom=max(1,(roomwidth)/(width-320),(roomheight+64)/(height-64))
zoomgo=zoom

window_set_size(width,height)
dx8_resize_buffer(width,height)
window_set_region_size(width,height,0)
window_center()

instance_create(0,0,Interface)
bgtex=background_get_texture(bgBlack)
knobtex=background_get_texture(bgKnob)

update_view()
change_mode(mode)
focus_object(objpal)

window_set_foreground()
