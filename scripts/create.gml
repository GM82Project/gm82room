globalvar copyvec,tty,width,height,gridx,gridy,interpolation,objpal,codeeditor,view,roomwidth,roomheight,mouse_wx,mouse_wy,mousein,grid,crosshair,removeoutside,fillwithcolor,fillcolor,remember,minimap,mode,buttoncol;
globalvar overlap_check,paladdbuttondown;

draw_set_font(fntCode)
draw_set_circle_precision(8)

global.col_low=$203020
global.col_main=$404040
global.col_high=$607060

width=display_get_width()-80-64
height=display_get_height()-80-64
maxfps=display_get_frequency()

room_speed=maxfps

xgo=0
ygo=0
zooming=0
zoom=1
mousein=0
zoomcenter=0
resizecount=0
objpal=noone
palettescroll=0
palettescrollgo=0
palettesize=0
paint=0
overlap_check=1
copyvec[0,0]=0
paladdbuttondown=0
select=noone
selecting=0
mode=4
grabview=0
sizeview=0

dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
grid=registry_read_dword(dir+"RoomGridOnOffDefault",0)
removeoutside=registry_read_dword(dir+"RemoveOutside",0)
fillwithcolor=registry_read_dword(dir+"FillRoomWithBackground",1)
fillcolor=registry_read_dword(dir+"RoomBackgroundFullColourDefault",$400040)
remember=registry_read_dword(dir+"RememberRoomSettings",0)
minimap=registry_read_dword(dir+"RoomMinimap",1)
crosshair=registry_read_dword(dir+"RoomCrosshair",1)
interpolation=registry_read_dword(dir+"RoomSmooth",1)
codeeditor=registry_read_string_ext(dir,"CodeEditor")
if (!file_exists(codeeditor)) codeeditor="notepad"
if (!registry_read_dword(dir+"NewRoomEditorSeen",0)) show_info()

state="load"
crc_init()
load_room()
state="run"

view[0]=1
view[1]=1
view[2]=1
view[3]=1
view[4]=0
view[5]=0
view[6]=0
update_visibility()

//adjust window to fit room
width=max(min_width,min(width,roomwidth+64+160*2))
height=max(min_height,min(height,roomheight+64+64))
xgo=roomwidth/2 ygo=roomheight/2
zoom=max(1,(roomwidth)/(width-320),(roomheight+64)/(height-64))
zoomgo=zoom

window_set_size(width,height)
window_resize_buffer(width,height)
window_set_region_size(width,height,0)
window_center()

instance_create(0,0,Interface)
bgtex=background_get_texture(bgBlack)

update_view()
