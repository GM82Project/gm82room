if (error_occurred) {
    error_occurred=0
    if (error_buffer) {
        show_message("The editor seems to be stuck in an error loop. The editor will now close.##Please send renex the error log.")
        execute_shell("explorer.exe","/select,"+qt+working_directory+"\game_errors.log"+qt)
        game_end()
        exit
    } else {
        error_buffer=true
        save_room(1)
        if (error_occurred) {
            show_message("Error detected:##"+error_last+"##The editor had an error, and then had an additional error while attempting to recover the project.##The editor will now close to protect your data.")
            game_end()
            exit
        }
        show_message("Error detected:##"+error_last+"##The editor has saved your work.##Please restart the editor and choose to load the autosave.")
    }
} else error_buffer=false
