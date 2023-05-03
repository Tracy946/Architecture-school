# Диаграмма ограниченных контекстов

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml
AddElementTag("microService", $shape=EightSidedShape(), $bgColor="CornflowerBlue", $fontColor="white", $legendText="microservice")

Person(customer, "Пользователь")

System_Boundary(c, "MTS Hello, Conference!") {
   Container(app, "Клиентское веб-приложение", "Сайт конференции")

   Container(bff_service, "Backend-For-Frontend", "Java, Spring Boot", "Сервис работы с backend") 

   Container(report_service, "Bounded Context", "Report Service, Сервис работы с докладами")      
   
   Container(conference_service, "Bounded Context", "Conference Service, Сервис работы с конференциями")      

   Container(user_service, "Bounded Context", "User Service, Сервис работы с пользователями")      

   Container(communication_service, "Bounded Context", "Communication Service, Сервис работы с чатами")      
 
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

Rel(conference_service, message_bus, "Получение данных о докладе, назначение рецензента", "AMPQ")
Rel(conference_service, translation_system, "Получение ссылки на запланированную конференцию", "SQL")

SHOW_LEGEND()
@enduml
```