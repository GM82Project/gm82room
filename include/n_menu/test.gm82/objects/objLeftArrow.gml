#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
scrCreateLeftArrowMenu();
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
N_Menu_DestroyMenu(window_handle(), menu2);
N_Menu_DestroyMenu(window_handle(), menu);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.menuItem == menuOkId) {
    show_message("ok");
}
#define KeyPress_37
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
N_Menu_ShowPopupMenu(window_handle(), menu, x + window_get_x(), y + window_get_y(), 0);
