step_windowzoom()

update_view()

step_hotkeys()
step_clipboard()
step_leftmouse()
step_rightmouse()

if (!instance_exists(modal)) {
    step_object()
    step_tile()
    step_view()
    step_path()
    step_settings()
}

step_contextmenu()

update_view()
