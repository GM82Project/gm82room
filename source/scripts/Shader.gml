///Shader(filename)

if (!ds_map_exists(shadermap,argument0)) {
    if (file_exists(root+argument0)) {
        shader=shader_pixel_create_file(root+argument0)
        dsmap(shadermap,argument0,shader)
    } else {
        show_message("Error while compiling instance preview field for "+objname+":##Shader file "+qt+root+argument0+qt+" doesn't exist.")
        disabled_preview=1
        return noone
    }
} else shader=dsmap(shadermap,argument0)

return shader
