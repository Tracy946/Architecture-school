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

### Вариант 3. Категория системы CAP
<!-- Описание варианта 3 -->
CAP-теорема описывает возможность распределенных систем одновременно обеспечивать только 2 свойства из 3-х: согласованность (Consistency), доступность (Availability) и устойчивость к разделению (Partition tolerance). Согласованность (Consistency) в САР означает линеаризуемость, а не фиксацию завершенной транзакции, как в ACID.

* **Плюсы**
  * Простота и удобство использования. CAP-теорема представляет собой простую логическую модель и легко применяется для решения задач, которые связаны с каскадными цепями.
  * Высокая точность вычислений. CAP-теорема позволяет получить точные результаты для простых задач, когда используется строгое соблюдение правил.
  * Не требует дополнительных усилий для расчета. CAP-теорема применяет стандартный набор логических правил и не требует дополнительных усилий для расчета.
  
* **Минусы**
  * Если сеть потеряет раздел, обновления в одном разделе могут не попасть в другие разделы до того, как клиент прочитает данные из устаревшего раздела после чтения из актуального. Единственное, что можно сделать  — это перестать обслуживать запросы из устаревшего раздела, но тогда сервис уже не будет доступен на 100%.
  * Может привести к ошибкам, если не учитывать все допущения. CAP-теорема предполагает определенные допущения, и если они не будут учтены, то это может привести к ошибкам в результатах.
  * Не подходит для сложных систем. CAP-теорема может использоваться только для решения простых задач, и она не подходит для сложных систем.


### Вариант 4. Категория системы PACELC
<!-- Описание варианта 4 -->
Теорема PACELC основана на модели CAP, но, помимо согласованности, доступности и устойчивости к разделению также включает временную задержку (L, Latency) и логическое исключение между сочетаниями этих понятий. Согласно PACELC, в случае сетевого разделения (P) в распределенной системе необходимо выбирать между доступностью (A) и согласованностью (C), как и в CAP- теореме, но в остальном (E, ELSE), даже при нормальной работе системы без разделения, нужно выбирать между задержкой (L) и согласованностью (C).

* **Плюсы**
  * Обеспечивает более точные результаты, чем другие методы. PACELC-теорема предлагает алгоритм, который позволяет получить более точные результаты для решения сложных задач и применима для различных систем.
  * Подходит для расчета сложных систем. PACELC-теорема легко применима для расчета сложных систем и позволяет рассчитывать моменты различных порядков.
  * Учитывает большое количество факторов. PACELC-теорема учитывает большое количество факторов, которые могут влиять на вычисления.
  
* **Минусы**
  * Требует больших усилий для расчета. PACELC-теорема представляет сложный алгоритм, и для его применения требуется значительный уровень подготовки и навыков.
  * Сложность использования. PACELC-теорема может быть сложной при использовании, особенно для тех, кто не имеет достаточного опыта в работы с этой теоремой.


## Решение
<!-- Описание выбранного решения. Решение должно быть сформулировано чётко ("Мы используем...", "Мы не используем", а не "Желательно.." или "Предлагается..."). 
Должна быть понятна связь между решением и проблемой, почему выбрали именно это решение из вариантов -->
Мы используем PACELC - это более новый подход, который предполагает комбинирование CAP и BASE в уравновешенный и гибкий способ. Он может обеспечить высокую доступность данных, при этом потеря точности и согласованности будет минимальной.
В системе мы также используем ACID. ACID необходимо использовать в сервисах, связанных с процессом согласования и проверки докладов, таких как система управления документами и база данных участников конференции. В этом случае, ACID базы данных обеспечивают целостность данных и поддерживают транзакционную безопасность.

## Последствия
<!-- Положительные и отрицательные последствия (trade-offs). Арх. решения, которые потребуется принять как следствие принятого решения. Если решение содержит риски, то описано, как с ними планируют поступить (за счет чего снижать, почему принять). -->