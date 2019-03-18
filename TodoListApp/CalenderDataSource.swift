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
  var Todos = [Todo]()
  var days :[Int] = (0...6).map{_ in
    let currentday = Calendar.current.component(.day, from: Date())
    return currentday
  }



  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return days.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCollectionViewCell
    let day = days[indexPath.item]
    let currentWeekDay = Calendar.current.component(.weekday, from: Date())
    cell.titleLabel.text = (day + 1 - currentWeekDay + indexPath.item).description
    if cell.titleLabel.text == day.description {cell.titleLabel.textColor = .red}
    cell.titleLabel.backgroundColor = .gray
    return cell
  }


}

extension CalenderDataSource:UICollectionViewDelegate{


}

extension CalenderDataSource:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    return CGSize(width: collectionView.tag == 0 ? width / 7 : width, height: 30)
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

struct Day:Codable {
  var date:Date
}

struct Todo:Codable {
  var title:String
  var type:Type
  var time:Date
  var alermTime:Date?

  enum `Type`:String,Codable {
    case red
    case blue
    case orange
  }
  init(title:String,type:Type,time:Date = Date(),alermTime:Date? = nil) {
    self.title = title
    self.type = type
    self.time = time
    self.alermTime = alermTime
  }
}


