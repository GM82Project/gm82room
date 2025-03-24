var i,j,icon,name,item;

toolmenuitems=ds_map_create()
toolmenu=N_Menu_CreatePopupMenu()

i=0
icon[i]=create_menu_bitmap(sprMenuButtons,33,"b33") name[i]="Swap Instance Objects" i+=1
icon[i]=create_menu_bitmap(sprMenuButtons,32,"b32") name[i]="Import Jtool map" i+=1
icon[i]=create_menu_bitmap(sprMenuButtons,31,"b31") name[i]="Parse Creation Code" i+=1
icon[i]=create_menu_bitmap(sprMenuButtons,29,"b29") name[i]="Clean Stacked Copies" i+=1
icon[i]=create_menu_bitmap(sprMenuButtons,26,"b26") name[i]="Glue Adjacent Instances" i+=1
icon[i]=create_menu_bitmap(sprMenuButtons,1 ,"b1") name[i]="Gigaknife" i+=1

thumbcount+=i

j=0 repeat (i) {
    item=N_Menu_AddItem(toolmenu,name[j],"")
    N_Menu_ItemSetBitmap(toolmenu,item,icon[j])
    ds_map_add(toolmenuitems,item,j)
j+=1}
