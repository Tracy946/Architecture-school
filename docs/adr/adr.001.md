# ADR.001 Выбор категории системы
<!-- Название ADR состоит из [ADR.###] [Коротко суть принятого решения] -->

* Статус: Принято
* Владелец: aasadikova@mts.com

## Контекст
<!-- Описание проблемы, требующей решения, причин, побудивших принять решение, ограничений, действовавших на момент принятия решения -->

Была запущена конференция helloconf.mts.ru и мы столкнулись с огромным количеством желающих подать доклад. Работа с докладчиками заключается в: 
- рецензирование доклада,
- отправка обратной связи,
- составить программу конференции.
Приложение должно содержать, как минимум, следующие функциональные блоки:
- работа с докладчиками,
- работа с расписаниями,
- проведение конференции (трансляция, сбор обратной связи).

## Варианты решения
<!-- Описание рассмотренных вариантов c их плюсами и минусами -->

### Вариант 1. Категория системы ACID
<!-- Описание варианта 1 -->
Обеспечение свойств ACID (Atomicity, Isolation, Durability) требуется до и после каждой транзакции, чтобы обеспечить согласованность в базе данных. 
* **Плюсы**
  * целостность и непротиворечивость данных,
  * поддерживает транзакции соответствия ACID,
  * запускает обновление быстро.
  
* **Минусы**
  * Требуют больше времени и усилий для разработки и поддержки схемы и нормализации данных,
  * время чтения медленнее из-за соединений.


### Вариант 2. Категория системы BASE
<!-- Описание варианта 2 -->
BASE адаптирует более низкий порог за счет возможной согласованности. То есть благодаря репликации все источники данных в конечном итоге будут иметь одни и те же данные. Однако не в момент совершения транзакции. 
* **Плюсы**
  * высокая производительность, 
  * доступность, 
  * репликация данных,
  * масштабируемость (горизонтальная).
  
* **Минусы**
  * Несовместимо с ACID и не применимо к транзакционным секторам, требующим соответствия ACID.

## Решение
<!-- Описание выбранного решения. Решение должно быть сформулировано чётко ("Мы используем...", "Мы не используем", а не "Желательно.." или "Предлагается..."). 
Должна быть понятна связь между решением и проблемой, почему выбрали именно это решение из вариантов -->
В системе мы используем ACID. ACID необходимо использовать в сервисах, связанных с процессом согласования и проверки докладов, таких как система управления документами и база данных участников конференции. В этом случае, ACID базы данных обеспечивают целостность данных и поддерживают транзакционную безопасность.
Мы используем PACELC - это более новый подход, который предполагает комбинирование CAP и BASE в уравновешенный и гибкий способ. Он может обеспечить высокую доступность данных, при этом потеря точности и согласованности будет минимальной.

## Последствия
<!-- Положительные и отрицательные последствия (trade-offs). Арх. решения, которые потребуется принять как следствие принятого решения. Если решение содержит риски, то описано, как с ними планируют поступить (за счет чего снижать, почему принять). -->
1. Риски:

Обе модели баз данных могут нести риски, связанные с сохранением целостности и консистентности данных. В случае неправильного проектирования и использования баз данных, может возникнуть потеря данных, повреждение базы данных и нарушение безопасности.

Однако, ACID имеет более высокий уровень защиты от потери данных и повреждения базы данных, благодаря обеспечению жесткой транзакционности данных.

2. Точки чувствительности:

ACID-совместимые базы данных очень чувствительны к обеспечению транзакционности данных и соблюдению принципов ограничения целостности данных. Обращение к данным в рамках транзакции, которая не была завершена или была опреределена, может привести к проблемам в работе приложений, использующих данные из этой базы.

BASE более гибкая модель с более слабыми требованиями к консистентности данных, что делает его менее чувствительным к внезапным изменениям данных, но в то же время менее защищенным от потери данных.

3. Точки компромисса:

ACID базы данных используются в транзакционных приложениях, где консистентность и надежность являются ключевыми. Для обеспечения результата в транзакции используются дополнительные ресурсы базы данных, что может увеличивать затраты памяти и процессорного времени.

В случае приложений с большим количеством пользователей, где требования к надежности не являются критическими, BASE базы данных могут быть более эффективными в плане производительности приложения. Также BASE подход может быть более легко масштабируемым, поскольку данные могут быть распределены между несколькими узлами кластера для распараллеливания операций.