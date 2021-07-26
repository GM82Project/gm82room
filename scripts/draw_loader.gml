draw_clear(global.col_main)
draw_text(32,8,loadtext)
buttoncol=global.col_main
draw_button(32,32,256,32,0)
u=(256-8)*progress
if (u) {
    draw_rectangle(36,36,36+u-1,36+32-8-1,0)
}
screen_refresh()
