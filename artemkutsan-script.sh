#!/usr/bin/env bash

read -p "Каталог: " DIR
read -p "Возраст в днях: " DAYS

FILES=$(find "$DIR" -type f -mtime +"$DAYS")

if [ -z "$FILES" ]; then
    echo "Файлов нет"
    exit 0
fi

echo "Найдены:"
for file in $FILES; do
    echo "$file"
done

read -p "Удалить? (да/нет): " ANSWER
if [ "$ANSWER" = "да" ]; then
    for file in $FILES; do
        rm -f "$file"
    done
    echo "Удалено"
else
    echo "Отменено"
fi
