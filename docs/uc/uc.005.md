# UC.005 Подача нового доклада
<!-- Подробное описание сценария использования системы с привязкой к ролям участников и задействованным бизнес-сущностям 
https://confluence.mts.ru/pages/viewpage.action?pageId=375782119 
-->
| Название | Подача нового доклада |
|:---------------------------|:------|
| Описание | Пользователь с ролью Докладчик хочет подать новый доклад после получения отказа по предыдущему |
| Участники | Пользователь с ролью **Докладчик**, Frontend, Backend |
| Триггер | **Докладчик** нажал на кнопку **Подать новый доклад** на странице **Доклады**|
| Предусловия | **Докладчик** получил отказ по предыдущему докладу |
| Постусловия | **Докладчик** отправил новый доклад |
| Успешный сценарий | 1. **Докладчик** загрузил файл нового доклада. 2. Frontend отправляет запрос на изменение статуса доклада на Backend. 3. Backend возвращает на Frontend HTTP 200 OK со ссылкой на файл доклада. 4. Frontend отображает подстраницу доклада со следующей информацией: полученный файл, статус доклада **Отправлено на рецензирование**. |
| Требования | *[FR.005](docs\README.md)*, *[FR.006](docs\README.md)*, *[FR.007](docs\README.md)*, *[FR.008](docs\README.md)* |

