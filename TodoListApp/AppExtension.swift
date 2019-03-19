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
  var mouthDay:Int{
    return Calendar.current.component(.day, from: self)
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
  var firstDayofMouth:Date {
    var componets = Calendar.current.dateComponents( [.year, .month], from: self)
    componets.day = monthDays.lowerBound
    return Calendar.current.date(from: componets)!
  }
}
