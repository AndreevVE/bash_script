#!/bin/bash

read -rp "Введите путь к каталогу: " dir

if [[ ! -d "$dir" ]]; then
  echo "Ошибка: каталога '$dir' не существует."
  exit 1
fi


read -rp "Введите возраст файлов в днях (например, 7): " days

# Проверяем, что введено число
if ! [[ "$days" =~ ^[0-9]+$ ]]; then
  echo "Ошибка: нужно ввести целое число."
  exit 1
fi

mapfile -t files < <(find "$dir" -type f -mtime +"$days" -print 2>/dev/null)

if ((${#files[@]} == 0)); then
  echo "Файлов старше $days дней в каталоге '$dir' не найдено."
  exit 0
fi

echo "Найдены следующие файлы старше $days дней:"
for f in "${files[@]}"; do
  echo "  $f"
done

read -rp "Удалить эти файлы? (да/нет): " answer

case "$answer" in
  "да"|"ДА"|"Да"|"y"|"Y"|"yes"|"YES"|"Yes")
    echo "Удаляю файлы..."
    for f in "${files[@]}"; do
      rm -f -- "$f"
      echo "Удалён: $f"
    done
    echo "Готово. Все указанные файлы удалены."
    ;;
  *)
    echo "Удаление отменено пользователем."
    ;;
esac
