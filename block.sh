#!/bin/bash 

param="$1" 

if [ -z "$param" ]; then 
    echo -e "\033[0;31mОшибка: укажите имя блока\033[0m" 
    exit 1 
fi 

filename="_${param}.scss" 

config_path="src/scss/blocks" 

path="$config_path/$filename" 
index_path="$config_path/_index.scss" 

use_line="@use '${param}' as *;" 

mkdir -p "$config_path" 

if [ -f "$path" ]; then 
    echo -e "\033[0;31mФайл $path уже существует\033[0m" 
else 
    echo -e "@use '../mixins' as *;\n\n// Блок: ${param}\n.${param} {\n    \n}" > "$path" 

    if [ ! -f "$index_path" ]; then 
        touch "$index_path" 
    fi 

    if ! grep -q "$use_line" "$index_path"; then 
        echo "$use_line" >> "$index_path" 
    fi 

    echo -e "\033[0;32mФайл $path создан, строка @use добавлена в $index_path\033[0m" 
fi