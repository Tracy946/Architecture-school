# Контекст решения
<!-- Окружение системы (роли, участники, внешние системы) и связи системы с ним. Диаграмма контекста C4 и текстовое описание. 
Подробнее: https://confluence.mts.ru/pages/viewpage.action?pageId=375783261
-->
```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_WITH_LEGEND()

Person(cs, "Conference Speaker", "A user of Conference Application who is a participant of a conference, with personal report.")
Person(cp, "Conference Participant", "A user of Conference Application who is a participant of a conference, without personal report.")
Person(cr, "Conference Reviewer", "A user of the application, with permission to approve or deny a Conference Speaker's report.")
Person(cm, "Conference Manager", "A user of Conference Application who is an organizer of a conference, with permission to create/update/delete conference information.")
Person(co, "Conference Operator", "A user of the application, with permission to broadcast a conference.")
Person(ats, "App Technical Support", "A user of the application, with permission to resolve application issues.")
System(ca, "Conference Application", "Allows Conference Speacer to communicate with Conference Reviewer about the report. Allows Conference Participant to listen to and view the conference. Allows Conference Manager to communicate with Conference Speaker, Conference Participant and create conference schedule. Allows Conference Operator to broadcast the conference. Allows App Technical Support to communicate with other type of users in order to resolve issues of the last ones.")
System_Ext(mcas, "Mainframe Conference Application System", "Stores all of the core conference information about users, conference schedule, reports, etc.")

Rel(cs, ac, "Uses")
Rel(cp, ac, "Uses")
Rel(cr, ac, "Uses")
Rel(co, ac, "Uses")
Rel(ats, ac, "Administrate")
Rel(cs, cr, "Sends report for reviewing to")
Rel(cr, cs, "Sends decision about report to")
Rel(cs, ats, "Sends issue description")
Rel(ats, cs, "Resolves user's issue")
Rel(cp, ats, "Sends issue description")
Rel(ats, cp, "Resolves user's issue")
Rel(cr, ats, "Sends issue description")
Rel(ats, cr, "Resolves user's issue")
Rel(cm, ats, "Sends issue description")
Rel(ats, cm, "Resolves user's issue")
Rel(co, ats, "Sends issue description")
Rel(ats, co, "Resolves user's issue")
Rel(ca, mcas, "Uses")
@enduml
```
