# Модель предметной области
<!-- Логическая модель, содержащая бизнес-сущности предметной области, атрибуты и связи между ними. 
Подробнее: https://confluence.mts.ru/pages/viewpage.action?pageId=375782602

Используется диаграмма классов UML. Документация: https://plantuml.com/class-diagram 
-->

```plantuml
@startuml
namespace ConferenceInformation {

 
 class Conference
 {
  id : string
  name : string
  date : datetime
  place : string
  stream : string
  chatId : string
  managerId : string
 }

 class ConferenceSchedule
 {
  confId : string
  time : time
  reportId : string
 }

 class ConferenceMember
 {
  confId : string
  userId : string
  userRole : RoleType
  reportUploaded : boolean
 }

 enum RoleType
 {
  user
  speaker
  participant
  reviewer
  manager
  operator
  support
 }
 ConferenceMember -- RoleType
 

 class ConferenceFeedback
 {
  id : string
  confId : string
  userId : string
  questionId : string
  score : integer
 }

 class FeedbackQuestion
 {
  id : string
  question : string
 }


 Conference *-- "1" ConferenceSchedule
 ConferenceMember "*"--"*" Conference
 ConferenceFeedback "*"--"*" FeedbackQuestion
 Conference *-- "*" ConferenceFeedback

}

 ConferenceInformation.ConferenceMember "*"--"*" Users.User


namespace Users{
class User
 {
  id : string
  firstName : string
  middleName : string
  lastName : string
  phone : string
  email : string
 }
}

namespace Reports {
 class Report
 {
  id : string
  speakerId : string
  name : string
  content : string
  conferenceId : string
 }

  class ReportReview
 {
  reportId : string
  reviewerId : string
  status : ReportStatus
  chatId : string
 }
 
 enum ReportStatus
 {
  sentForReview
  inReview
  needsImprovement
  accepted
  rejected
 }
 ReportReview -- ReportStatus
 Report *--"1" ReportReview
 Reports.Report "*"--* ConferenceInformation.ConferenceSchedule

}


namespace Communication {
  class Chat
 {
  id : string
  type : ChatType
 }

 enum ChatType
 {
  report
  support
  manager
 }

  class Message
 {
  id : string
  body : string
  reportId : string
  recipientId : string
  senderId : string
  chatId : string
  status : MessageSatus
 }

 enum MessageStatus
 {
  sent
  isRead
  notRead
  failed
 }

  class ChatRef
 {
  userId : string
  chatId : string
 }

 Chat -- ChatType
 Chat "1"--"*" Message
 Users.User "*"--"*" Chat
 Users.User "1"--"*" Message
 Reports.Report "1"--"1" Message
 Users.User "*"--"*" ChatRef
 Chat "*"--"*" ChatRef
 Message -- MessageStatus

}
@enduml
```
