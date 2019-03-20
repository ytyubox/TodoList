//
//  AppExtension.swift
//  TodoListApp
//
//  Created by 游宗諭 on 2019/3/18.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

extension UIColor{

  convenience init(r:Int,g:Int,b:Int){
    let r = CGFloat(r),g = CGFloat(g), b =  CGFloat(b)
    self.init(red: r / 255.0, green: g  / 255.0, blue: b / 255.0, alpha: 1)
  }

  static var todoRed:UIColor {
    let code = "FF4355".RGB_Htoi
    return UIColor(r: code.r, g: code.g, b: code.b)
  }

  static var todoOrange:UIColor {
    let code = "FBAA21".RGB_Htoi
    return UIColor(r: code.r, g: code.g, b: code.b)
  }
  static var todoBlue:UIColor {
    let code = "0063FF".RGB_Htoi
    return UIColor(r: code.r, g: code.g, b: code.b)
  }
}
extension String{
  var RGB_Htoi:(r:Int,g:Int,b:Int){
    guard (self.filter{"0123456789ABCDEF".contains($0)}.count  == 6) else {fatalError(self + " is not a RGB color code")}
    let gIndex = self.index(self.startIndex, offsetBy: 2)
    let bIndex = self.index(self.startIndex, offsetBy: 4)
    let r = Int(self[..<gIndex], radix: 16)!
    let g = Int(self[gIndex..<bIndex], radix: 16)!
    let b = Int(self[bIndex...], radix: 16)!
    return (r,g,b)
  }

}

extension UIButton{

  func switchArrow() {
    guard var title = currentTitle,
      "▲▼".contains(title.last!) else { return }

    switch title.removeLast() == "▲"{
    case true:  title += "▼"
    case false: title += "▲"
    }
    setTitle(title, for: .normal)
  }
}

extension Date{
  var month:String{
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("MMMM")
    return formatter.string(from: self)
  }
  var monthDays:Range<Int>{
    return Calendar.current.range(of: .day, in: .month, for: self)!
  }
  var monthDay:Int{
    return Calendar.current.component(.day, from: self)
  }
  var weekDay:Int{
    return Calendar.current.component(.weekday, from: self)  - 1
  }
  var firstDayofMonth:Date {
    var componets = Calendar.current.dateComponents( [.year, .month], from: self)
    componets.day = monthDays.lowerBound
    return Calendar.current.date(from: componets)!
  }
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

extension UIView{
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    #if DEBUG
    print(self.description)
    #endif
    super.touchesBegan(touches, with: event)
    next?.touchesBegan(touches, with: event)
  }
}


extension String{
  func makeDot(type:Todo.TodoType)->NSAttributedString{
    guard  self == "●" else { fatalError(self + " is not a dot.")   }
    let typeText: [NSAttributedString.Key:Any] = [
      .font             :UIFont.systemFont(ofSize: 30),
      .foregroundColor  : type.color
    ]
    return NSAttributedString(string: self, attributes: typeText)
  }
  var titleText:NSAttributedString{
    let titleText: [NSAttributedString.Key:Any] = [
      .font             :UIFont.systemFont(ofSize: 30),
      .foregroundColor  :UIColor.black
    ]
    return NSAttributedString(string: self, attributes: titleText)
  }
  var descriptionText:NSAttributedString{
    let descriptionText: [NSAttributedString.Key:Any] = [
      .font             :UIFont.systemFont(ofSize: 20),
      .foregroundColor  :UIColor.lightGray
    ]
    return NSAttributedString(string: self, attributes: descriptionText)
  }
}
