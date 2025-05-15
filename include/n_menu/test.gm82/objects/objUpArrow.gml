#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
toolWin = -1;
menu = -1;
menuUpOkId = -1;

menu3 = N_Menu_CreatePopupMenu();
N_Menu_AddItem(menu3, "test 1", "");
N_Menu_AddItem(menu3, "test 2", "");
menuUpCancelId = N_Menu_AddItem(menu3, "test 3", "");
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (N_Menu_GetToolWindowExists(toolWin)) N_Menu_DestroyToolWindow(toolWin);
N_Menu_DestroyMenu(window_handle(), menu3);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.menuItem == menuUpOkId) {
    show_message("up ok");
    if (N_Menu_GetToolWindowExists(toolWin)) {
        N_Menu_AttachMenuBar(toolWin, 0);
        N_Menu_DestroyToolWindow(toolWin);
    }
}

if (global.menuItem == menuUpCancelId) {
    show_message("up cancel");
}
#define KeyPress_38
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!N_Menu_GetToolWindowExists(toolWin)) {
    toolWin = N_Menu_CreateToolWindow("Up arrow menu", window_get_x() + x, window_get_y() + y, 200, N_Menu_GetMenuBarHeight(), false);
    scrCreateUpArrowMenu();
    N_Menu_AttachMenuBar(toolWin, menu);
    N_Menu_ShowPopupMenu(toolWin, menu3, 50, 50, 0);
}
