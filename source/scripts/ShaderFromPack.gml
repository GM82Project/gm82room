///ShaderFromPack(script name)

if (!ds_map_exists(shadermap,argument0)) {
    file=root+"scripts\"+argument0+".gml"
    if (file_exists(file)) {
        shader=execute_file(file)
        dsmap(shadermap,argument0,shader)
    } else {
        show_error("ShaderFromPack() field nonexisting shader script: "+qt+argument0+qt,0)
    }
} else shader=dsmap(shadermap,argument0)

return shader
