import UIKit



let format = DateFormatter()
format.setLocalizedDateFormatFromTemplate("EEE")

format.string(for: 1)
func makeTheDate(month:Int,day:Int,year:Int,hour:Int = 0 ,minute:Int = 0)->Date?{
  let calendar = Calendar.current

  var components = DateComponents()

  components.day = day
  components.month = month
  components.year = year
  components.hour = hour
  components.minute = minute

  return calendar.date(from: components)
}

var monthDay = [Int]()
let today = makeTheDate(month: 3, day: 17, year: 2019)!
let formatter = DateFormatter()
formatter.dateFormat = "EEEE"
var otherweekdayStrings: [String] = []
for i in 0...6 {
  let timeIntervalToAdd = TimeInterval(i * 86400)
  otherweekdayStrings.append(formatter.string(from: today.addingTimeInterval(timeIntervalToAdd)))
}
otherweekdayStrings


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


extension Date{
  static
    func makeTheDate(month:Int,day:Int,year:Int,hour:Int = 0 ,minute:Int = 0)->Date?{
    let calendar = Calendar.current

    var components = DateComponents()

    components.day = day
    components.month = month
    components.year = year
    components.hour = hour
    components.minute = minute

    return calendar.date(from: components)
  }
}

print(Date.makeTheDate(month: 12, day: 4, year: 1698)!)

//let calendar = Calendar.current

var components = DateComponents()

components.day = 25
components.month = 1
components.year = 2011
components.hour = -5
components.minute = 15

let newDate = calendar.date(from: components)

print(newDate)
