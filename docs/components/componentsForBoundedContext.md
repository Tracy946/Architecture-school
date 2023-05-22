# Диаграмма контейнеров для всех ограниченных контекстов

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

AddElementTag("microService", $shape=EightSidedShape(), $bgColor="CornflowerBlue", $fontColor="white", $legendText="microservice")
AddElementTag("storage", $shape=RoundedBoxShape(), $bgColor="lightSkyBlue", $fontColor="white")

Person(customer, "Пользователь")

System_Boundary(c, "MTS Hello, Conference!") {

   System_Boundary(bfe, "Frontend") {
   Container(app, "Клиентское веб-приложение", "html, JavaScript, Angular", "Сайт конференции")
   }

   System_Boundary(brs, "Report Service") {
   Container(report_service, "Report Service", "Java, Spring Boot", "Сервис работы с докладами", $tags = "microService")      
   ContainerDb(report_db, "Reports", "PostgreSQL", "Хранение данных о докладах", $tags = "storage")
   }

   System_Boundary(bcs, "Conference Service") {
   Container(bff_service, "Backend-For-Frontend", "Java, Spring Boot", "Сервис работы с backend", $tags = "microService") 
   Container(conference_service, "Conference Service", "Java, Spring Boot", "Сервис работы с конференциями", $tags = "microService")      
   ContainerDb(conference_db, "ConferenceInformation", "PostgreSQL", "Хранение данных о конференциях", $tags = "storage")
   }

   System_Boundary(bus, "User Service") {
   Container(user_service, "User Service", "Java, Spring Boot", "Сервис работы с пользователями", $tags = "microService")      
   ContainerDb(user_db, "Users", "PostgreSQL", "Хранение данных о пользователях", $tags = "storage")
   }

   System_Boundary(bcoms, "Communication Service") {
   Container(communication_service, "Communication Service", "Java, Spring Boot", "Сервис работы с чатами", $tags = "microService")      
   ContainerDb(communication_db, "Communication", "PostgreSQL", "Хранение данных о сообщениях и чатах", $tags = "storage")
   }

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