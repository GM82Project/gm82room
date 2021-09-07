//preferences modal
var c;

show_message("Preferences is a work in progress.")
new=show_message_ext("Choose theme:","Dark","Light","Custom")-1

if (new!=-1) {
    theme=new
    if (theme==2) {
        themebutton=show_message_ext("Which type of button?","Regular","Spicy","Thick")
        c[0]=get_color_ext(global.col_main,"Pick the fill colour:")
        c[1]=get_color_ext(global.col_high,"Pick the light colour:")
        c[2]=get_color_ext(global.col_low,"Pick the dark colour:")
        c[3]=get_color_ext(global.col_text,"Pick the text colour:")
        global.col_main=c[0]
        global.col_high=c[1]
        global.col_low=c[2]
        global.col_text=c[3]
    }
    load_theme()
    show_message("Theme applied.")
}
