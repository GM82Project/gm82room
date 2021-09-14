progress=argument1

draw_clear(global.col_main)
draw_set_color(global.col_text)
draw_text(32,8,argument0)
draw_set_color($ffffff)
draw_button_ext(32,32,256,32,0,global.col_main)
u=(256-8)*progress
if (u) {
    draw_rectangle(36,36,36+u-1,36+32-8-1,0)
}
io_handle()
screen_refresh()
