#!/bin/bash
read -rp "Введите путь к каталогу: " dir

if [[ ! -d "$dir" ]]; then
    echo "Ошибка: каталога '$dir' не существует."
    exit 1
fi


read -rp "Старше скольких дней удалять файлы? " days

if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: нужно ввести число дней."
    exit 1
fi

echo "Ищу файлы в каталоге '$dir', старше $days дней..."
mapfile -t files < <(find "$dir" -type f -mtime +"$days")

if [[ ${#files[@]} -eq 0 ]]; then
    echo "Файлы старше $days дней не найдены."
    exit 0
fi

echo "Найдены файлы:"
printf "%s\n" "${files[@]}"

read -rp "Удалить эти файлы? (yes/no): " confirm
confirm=${confirm,,}

if [[ "$confirm" != "yes" && "$confirm" != "y" ]]; then
    echo "Удаление отменено."
    exit 0
fi

for f in "${files[@]}"; do
    rm -v "$f"
done

echo "Файлы удалены."