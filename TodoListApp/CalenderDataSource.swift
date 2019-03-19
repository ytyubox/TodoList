//
//  CalenderDataSoure.swift
//  TodoListApp
//
//  Created by 游宗諭 on 2019/3/18.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class CalenderDataSource: NSObject, UICollectionViewDataSource {
  var controller:UICollectionViewDelegate?
  var todos: [Todo] = [
    Todo(title: "do something", type: .red, description: "ABC"),
    Todo(title: "do something", type: .blue),
    Todo(title: "do something", type: .orange)
  ]
  var days :[Int] =
  {
    var first =  Date().firstDayofMouth.weekDay
    var a =  Array(Date().monthDays)
    return  (0..<first).reversed().map{-$0} + a
  }()



  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionView.tag == 0  ? days.count : todos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch collectionView.tag {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCollectionViewCell
      let day = days[indexPath.item]
      let currentWeekDay = Calendar.current.component(.weekday, from: Date())
      cell.titleLabel.text = day > 0 ?  day.description : ""
      if cell.titleLabel.text == Date().monthDay.description {cell.titleLabel.textColor = .red}
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as! TodoCollectionViewCell
      let todo = todos[indexPath.item]
      cell.todo = todo

      return cell

    }
  }


}

extension CalenderDataSource:UICollectionViewDelegate{


}

extension CalenderDataSource:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    return CGSize(width: collectionView.tag == 0 ? (width - 10) / 7 : width - 50,
                  height: collectionView.tag == 0 ? 30 : 85)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

struct CalData:Codable {
  var date:Date
}

struct Todo:Codable {
  var title:String
  var type:TodoType
  var description:String?
  var time:Date
  var alermTime:Date?

  enum TodoType:String,Codable {
    case red
    case blue
    case orange

    var color:UIColor{
      switch self {
      case .red:
        return .todoRed
      case .blue:
        return .todoBlue
      case .orange:
        return .todoOrange
      }
    }
  }
  init(title:String,type:TodoType,description:String = "", time:Date = Date(),alermTime:Date? = nil) {
    self.title = title
    self.type = type
    self.time = time
    self.alermTime = alermTime
  }
}


