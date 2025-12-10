# Задача: Очистка старых файлов в каталоге
# Условие:
# Напишите bash-скрипт, который:
# Запрашивает у пользователя путь к каталогу.
# Запрашивает возраст файлов в днях (например, 7).
# Использует цикл для поиска всех файлов старше указанного количества дней.
# Показывает пользователю список найденных файлов.
# Запрашивает подтверждение на удаление (да/нет).
# Если подтверждено — удаляет файлы и сообщает об этом.

#!/bin/bash
read -p "Путь к каталогу: " directory
if [ ! -d "$directory" ]; then
    echo "Нет такого каталога"
    exit 1
fi

read -p "Возраст в днях: " age
read -p "Глубина поиска: " depth

files=0
echo "Найденные файлы: "
find "$directory" -maxdepth "$depth" -type f -mtime +$age | while IFS= read -r file; 
do
    echo "$file"
    ((files++))
done

if [ $files -eq 0 ]; then
    echo "Нет таких файлов"
    exit 0
fi
#
read -p "Удалить эти файлы? (y/n):" confirm

if [ "$confirm" = "y" ];
then
    find "$directory" -maxdepth "$depth" -type f -mtime +$age -delete
    echo "Удалено"
else 
    echo "Удаление было отменено"
fi

