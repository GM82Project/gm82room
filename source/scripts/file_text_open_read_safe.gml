if (file_exists(argument0)) return file_text_open_read(argument0)
show_error("Error loading project - required file not found: "+chr(13)+lf+chr(13)+lf+argument0,1)
return 0
