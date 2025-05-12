///scrCreateLeftArrowMenu()

menu = N_Menu_CreatePopupMenu();
menu2 = N_Menu_CreatePopupMenu();
N_Menu_AddMenu(menu, menu2, "ok menu");
menuOkId = N_Menu_AddItem(menu2, "ok", "");
