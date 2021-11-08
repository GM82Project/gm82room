globalvar copyvec,tty,width,height,gridx,gridy,interpolation,objpal,instancecount,tilecount,codeeditor,view,roomwidth,roomheight,mouse_wx,mouse_wy,mousein,grid,crosshair,removeoutside,fillwithcolor,fillcolor,remember,minimap,mode;
globalvar overlap_check,tile_overlap_check,paladdbuttondown,bg_current,vw_current,ly_current,ly_depth,tilebgpal,zoom;
globalvar chunkcrop,chunkleft,chunktop,chunkwidth,chunkheight,grabchunk,sizechunk,chunkloaded,chunkname;
globalvar selection,selleft,seltop,selwidth,selheight,selsize,grabselection;
globalvar theme,buttontex,themebutton;

draw_set_font(fntCode)
draw_set_circle_precision(8)

message_caption(1,"Message")
message_size(500,-1)

width=display_get_width()-80-64
height=display_get_height()-80-64
maxfps=display_get_frequency()

room_speed=maxfps
room_caption="Game Maker 8.2 Room Editor"

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

undo_initialize()

dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
grid=registry_read_dword(dir+"RoomGridOnOffDefault",0)
removeoutside=registry_read_dword(dir+"RemoveOutside",0)
fillwithcolor=registry_read_dword(dir+"FillRoomWithBackground",1)
fillcolor=registry_read_dword(dir+"RoomBackgroundFullColourDefault",$400040)
remember=registry_read_dword(dir+"RememberRoomSettings",0)
//minimap=registry_read_dword(dir+"RoomMinimap",1)
crosshair=registry_read_dword(dir+"RoomCrosshair",1)
interpolation=registry_read_dword(dir+"RoomSmooth",1)
codeeditor=registry_read_string_ext(dir,"CodeEditor")
if (!file_exists(codeeditor)) codeeditor="notepad"
seen=registry_read_dword(dir+"NewRoomEditorSeen",0)
theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)
if (theme==2) {
    global.col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
    global.col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
    global.col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
    global.col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
    themebutton=registry_read_dword(dir+"GM82CustomThemeButtonType",0)
}
codeeditortype=registry_read_dword(dir+"GM82CodeEditorType",0)

load_theme()
load_palette()

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
change_mode(mode)
focus_object(objpal)
