# ADR.002 Сравнение протоколов взаимодействия
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
Далее описано сравнение асинхронного и сихронного взаимодействия по следующим критериям: скорость выполнения, надежность, объем обрабатываемых данных, сложность реализации, гибкость и расширяемость.

### Скорость выполнения
Синхронное взаимодействие может быть быстрее, так как системы работают с данными одновременно, что позволяет проводить быструю обработку данных и реагировать на изменения в режиме реального времени. Однако, асинхронный подход может быть более гибким в управлении временными задержками обработки данных, что может быть полезным при работе с большими объемами информации.

### Надежность
Синхронное взаимодействие может быть более надежным, благодаря обеспечению моментальной обработки данных, что позволит быстро реагировать на ошибки и проблемы в системе. Однако, при выборе асинхронного подхода, система может обрабатывать данные в удобное для себя время, избегая потенциальных блокировок, что может быть полезно при обработке больших объемов данных, когда синхронный подход может вызывать задержки и снижать надежность системы.

### Объем обрабатываемых данных
Асинхронное взаимодействие может быть более эффективным при обработке больших объемов данных, так как принцип работы данного метода позволяет системе обрабатывать данные не одновременно, а по мере их поступления. В тоже время, синхронный подход предполагает операции над данными одновременно, что может снижать эффективность системы при работе с большими объемами информации.

### Гибкость и расширяемость
Асинхронное взаимодействие может быть более гибким и расширяемым, так как позволяет добавлять новые функциональные возможности в любой момент времени, не прерывая основные процессы работы системы. Синхронный подход может быть менее гибким и расширяемым, так как принцип работы данного метода ограничивает изменения в работе системы после ее запуска.

## Решение
<!-- Описание выбранного решения. Решение должно быть сформулировано чётко ("Мы используем...", "Мы не используем", а не "Желательно.." или "Предлагается..."). 
Должна быть понятна связь между решением и проблемой, почему выбрали именно это решение из вариантов -->

Мы используем смешанную интеграцию.
Смешанная интеграция сочетает в себе преимущества асинхронной и синхронной интеграции. Это означает, что для некоторых задач используем асинхронный подход (в части коммуникаций). Для других задач применяем синхронный подход, когда мы ждем ответа от другого сервиса.

Для взаимодействия между сервисами используем различные протоколы, такие как REST и EDA:
1. Сервис управления докладами отправляет сообщения о новых докладах, используя EDA, сервису Пользователи, с целью проверки доклада.
2. Сервис проверки докладов принимает запросы на проверку через REST API и отправляет сообщения о результатах проверки доклада другим сервисам, используя EDA.
3. Сервис управления конференциями принимает запросы на создание/получение расписания через REST API и получать уведомления от сервиса управления докладами, используя EDA, о докладах, которые необходимо включить в расписание.
4. Сервис Коммуникации принимает запросы через WebSockets от сервиса управления конференциями о начале и окончании конференции для отображения чата трансляции.
5. Сервис Коммуникации принимает запросы через WebSockets от сервиса Пользователи для общения с **Менеджером**, **Технической поддержкой** и **Рецензентом**.

## Решение
<!-- Описание выбранного решения. Решение должно быть сформулировано чётко ("Мы используем...", "Мы не используем", а не "Желательно.." или "Предлагается..."). 
Должна быть понятна связь между решением и проблемой, почему выбрали именно это решение из вариантов -->
1. Риски:

Асинхронное и синхронное взаимодействие могут нести риски относительно латентности системы и усиления задержек передачи данных. В асинхронном взаимодействии, сервис может отправлять запросы на другой сервис без ожидания ответа от него, что может привести к задержке в получении результата.

Синхронное взаимодействие может привести к блокировке вызывающего сервиса, если вызванный сервис не отвечает в течение определенного времени.

Смешанное взаимодействие компенсирует недостатки асинхронного и синхронного взаимодействия путем комбинирования их лучших качеств.

2. Точки чувствительности:

Синхронное взаимодействие имеет высокие требования к доступности сервисов, поскольку задержка в ответе может привести к потере пользователей. Асинхронное взаимодействия более подходит для более слабо связанных систем, где нет прямой зависимости между вызывающим и вызываемым сервисами.

Смешанное взаимодействие позволяет сочетать преимущества обоих подходов в зависимости от конкретного случая использования сервисов.

3. Точки компромисса:

Синхронное взаимодействие может быть более простым и понятным в реализации, но может стать менее эффективным при обработке большого количества запросов и вызовов.

Асинхронное взаимодействие может быть более эффективным при обработке большого количества запросов и вызовов, но может привести к сложности в обработке ошибок и управлении транзакциями.

При использовании смешанного взаимодействия, сервисы могут извлекать преимущества из обоих подходов, максимизировать эффективность и гибкость системы. В частности, асинхронное взаимодействие может быть использовано для обработки множества запросов, в то время как синхронное взаимодействие может быть использовано для обработки транзакций и достижения соответствующего уровня гарантий. В целом, смешанное взаимодействие может обеспечивать оптимальное сочетание между производительностью, управляемостью и гибкостью, не ущерб для надежности и простоты использования приложения.