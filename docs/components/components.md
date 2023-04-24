# Компонентная архитектура
<!-- Состав и взаимосвязи компонентов системы между собой и внешними системами с указанием протоколов, ключевые технологии, используемые для реализации компонентов.
Диаграмма контейнеров C4 и текстовое описание. 
Подробнее: https://confluence.mts.ru/pages/viewpage.action?pageId=375783368
-->
## Контейнерная диаграмма

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

AddElementTag("microService", $shape=EightSidedShape(), $bgColor="CornflowerBlue", $fontColor="white", $legendText="microservice")
AddElementTag("storage", $shape=RoundedBoxShape(), $bgColor="lightSkyBlue", $fontColor="white")

Person(customer, "Пользователь")

System_Boundary(c, "MTS Hello, Conference!") {
   Container(app, "Клиентское веб-приложение", "html, JavaScript, Angular", "Сайт конференции")
   Container(bff_service, "Backend-For-Frontend", "Java, Spring Boot", "Сервис работы с backend", $tags = "microService") 
   Container(report_service, "Report Service", "Java, Spring Boot", "Сервис работы с докладами", $tags = "microService")      
   ContainerDb(report_db, "Reports", "PostgreSQL", "Хранение данных о докладах", $tags = "storage")
   
   Container(conference_service, "Conference Service", "Java, Spring Boot", "Сервис работы с конференциями", $tags = "microService")      
   ContainerDb(conference_db, "ConferenceInformation", "PostgreSQL", "Хранение данных о конференциях", $tags = "storage")

   Container(user_service, "User Service", "Java, Spring Boot", "Сервис работы с пользователями", $tags = "microService")      
   ContainerDb(user_db, "Users", "PostgreSQL", "Хранение данных о пользователях", $tags = "storage")

   Container(communication_service, "Communication Service", "Java, Spring Boot", "Сервис работы с чатами", $tags = "microService")      
   ContainerDb(communication_db, "Communication", "PostgreSQL", "Хранение данных о сообщениях и чатах", $tags = "storage")
    
   Container(message_bus, "Message Bus", "RabbitMQ", "Транспорт для бизнес-событий")
}
System_Ext(translation_system, "Zoom", "Система проведения трансляций")  

Rel(customer, app, "Регистрация на конференцию / Прохождение рецензирования / Составление расписания / Просмотр трансляции", "HTTPS")
Rel(app, bff_service, "Отправка запроса", "JSON, HTTPS, WebSockets")
Rel(bff_service, report_service, "Загрузка и выгрузка доклада", "JSON, HTTPS")
Rel(bff_service, user_service, "Получение, создание и обновление данных о пользователе", "JSON, HTTPS")
Rel(bff_service, conference_service, "Получение, создание и обновление данных о конференции", "JSON, HTTPS")
Rel(bff_service, communication_service, "Чтение и запись сообщений в чатах", "WebSockets")


Rel(report_service, message_bus, "Отправка данных о докладе", "AMPQ")
Rel(report_service, report_db, "Сохранение данных о докладе и связанной информации", "SQL")

Rel(conference_service, message_bus, "Получение данных о докладе, назначение рецензента", "AMPQ")
Rel(conference_service, conference_db, "Сохранение данных о конференции и докладе", "SQL")
Rel(conference_service, translation_system, "Получение ссылки на запланированную конференцию", "SQL")


Rel(user_service, user_db, "Получение, создание и обновление данных о пользователях", "SQL")
Rel(communication_service, communication_db, "Чтение и запись сообщений в чатах", "SQL")



SHOW_LEGEND()
@enduml
```

## Список компонентов
| Компонент             | Роль/назначение                  |
|:----------------------|:---------------------------------|
| Пользователь | Пользователь системы с ролью **Пользователь**, **Слушатель**, **Докладчик**, **Рецензент**, **Менеджер**, **Оператор** или **Техническая поддержка** |
| Клиентское веб-приложение | Презентационная часть системы, её пользовательский интерфейс и связанные с ним компоненты. Предназначен для работы с докладами, конференциями и трансляциями |
| Backend-For-Frontend | Сервис, предназначенный для работы с другими микросервисами системы и получения от них данных, форматирования этих данных, чтобы они корректно обрабатывались на фронтенде и отправления данных фронтенду |
| Report Service | Сервис, предназначенный для работы с докладами в части прохождения процедуры рецензирования |
| Reports | База данных Report Service, предназначенныя для хранения данных о докладах и связанной с ними информации |
| Conference Service | Сервис, предназначенный для работы с конференциями, в части составления расписания конференции, назначении менеджера конференции, рецензента на определенный доклад |
| ConferenceInformation | База данных Conference Service, предназначенная для хранения данных о конференции|
| User Service | Сервис, предназначенный для работы с пользователями системы |
| Users | База данных User Service, предназначенная для хранения данных о пользователях системы |
| Communication Service | Сервис, предназначенный для организации чатов (с рецензентом, менеджером, тех.поддержкой) в системе |
| Communication | База данных Communication Service, предназначенная для хранения сообщений в чатах |
| Message Bus | Очередь сообщений, предназначенная для осуществления асинхронного взаимодействия между Report Service и Conference Service |
| Stream | Внешняя система, предназначенная для планирования и проведения трансляции |

