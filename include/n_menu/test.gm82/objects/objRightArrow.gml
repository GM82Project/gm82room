#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
check = N_Menu_LoadBitmap("check.bmp");
face = N_Menu_LoadBitmap("face.bmp");

recreate = true;
menuAttached = false;

if (recreate) {
    menu = -1;
    rightok1 = -1;
    rightok2 = -1;
    rightok3 = -1;
    rightok4 = -1;
    rightok5 = -1;
    rightok6 = -1;
    rightok7 = -1;
    rightok8 = -1;
    rightok9 = -1;
    rightok10 = -1;
    rightok11 = -1;
    rightok12 = -1;
} else {
    scrCreateRightArrowMenu();
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (menuAttached) {
    N_Menu_AttachMenuBar(window_handle(), menu);
}

N_Menu_DestroyBitmap(face);
N_Menu_DestroyBitmap(check);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (global.menuItem) {
case rightok1: show_message("rightok1"); break;
case rightok2: show_message("rightok2"); break;
case rightok3: show_message("rightok3"); break;
case rightok4: show_message("rightok4"); break;
case rightok5: show_message("rightok5"); break;
case rightok6: show_message("rightok6"); break;
case rightok7: show_message("rightok7"); break;
case rightok8: show_message("rightok8"); break;
case rightok9: show_message("rightok9"); break;
case rightok10: show_message("rightok10"); break;
case rightok11: show_message("rightok11"); break;
case rightok12:
    var msg1;
    var msg2;

    msg1 = N_Menu_ItemGetText(rightpopup3, rightok5);
    msg2 = N_Menu_ItemGetText(rightpopup7, rightok12);

    show_message(msg1);
    show_message(msg2);
    break;
}
#define KeyPress_39
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!menuAttached) {
    if (recreate) scrCreateRightArrowMenu();
    N_Menu_AttachMenuBar(window_handle(), menu);
    menuAttached = true;
} else {
    // Contrary to the documentation, N_Menu_AttachMenuBar is actually a toggle.
    // If the window doesn't have a menu bar, it will attach menu as the menu bar.
    // If the window has a menu bar, it will remove and destroy the menu bar.
    N_Menu_AttachMenuBar(window_handle(), menu);
    menuAttached = false;
}
