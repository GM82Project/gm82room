var hash;

do {
    hash=""
    repeat (8) hash+=choose("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F")
} until (!ds_map_exists(uidmap,hash))

argument0.uid=hash
ds_map_add(uidmap,hash,argument0)
