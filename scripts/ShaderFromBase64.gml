///ShaderFromBase64(string)

if (!ds_map_exists(shadermap,argument0)) {
    shader=shader_pixel_create_base64(argument0)
    dsmap(shadermap,argument0,shader)
} else shader=dsmap(shadermap,argument0)

return shader
