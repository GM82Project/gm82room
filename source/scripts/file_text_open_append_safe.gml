if (file_exists(argument0)) return file_text_open_append(argument0)
show_error("Error loading project - required file not found: "+crlf+crlf+argument0,1)
return 0
