import UIKit

var monthDay = [Int]()

var calendar = Calendar.current

calendar.component(.calendar, from: Date())
calendar.component(.day, from: Date())

let rc =   Calendar(identifier: .iso8601)
calendar.component(.month, from: Date())
calendar.component(.era, from: Date())
calendar.component(.weekdayOrdinal, from: Date())
calendar.component(.hour, from: Date())

let date = Date()

calendar.range(of: .day, in: .month, for: date)?.count
extension Date{
  var monthDays:Range<Int>{
    return Calendar.current.range(of: .day, in: .month, for: self)!
  }
  var monthDay:Int{
    return Calendar.current.component(.day, from: self)
  }
  var weekDay:Int{
    return Calendar.current.component(.weekday, from: self)  - 1
  }
  var firstDayofMouth:Date {
    var componets = Calendar.current.dateComponents( [.year, .month], from: self)
    componets.day = monthDays.lowerBound
    return Calendar.current.date(from: componets)!
  }

}
let today = calendar.startOfDay(for: Date())
let dayOfWeek = calendar.component(.weekday, from: today)
let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
let days = weekdays
  .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }  // use `flatMap` in Xcode versions before 9.3
  //.filter { !calendar.isDateInWeekend($0) }//.map{$0.monthDay}
let range = calendar.range(of: .day, in: .month, for: date)!
var firstDayComponents = calendar.dateComponents([.year, .month], from: date)
firstDayComponents.day = range.lowerBound
let firstDay = calendar.date(from: firstDayComponents)!
firstDay.weekDay
date.firstDayofMouth

let formatter = DateFormatter()
formatter.dateFormat = "eeee' = 'D"
days.map{formatter.string(from: $0)}.forEach{print($0)}



date.monthDays

