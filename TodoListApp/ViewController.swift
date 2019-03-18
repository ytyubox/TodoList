//
//  ViewController.swift
//  TodoListApp
//
//  Created by 游宗諭 on 2019/3/18.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var calenderCollectView: UICollectionView!
  @IBOutlet var todoListCollectionView: UICollectionView!
  @IBOutlet var titlebutton: UIButton!
  var a1 = (1...7).map{$0}
   var a2 = (10...20).map{$0}
  var calenderDataSource = CalenderDataSource()
}

extension ViewController{

  override func viewDidLoad() {
    super.viewDidLoad()
//    let  calenderDataSource = CalenderDataSource()
    calenderCollectView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
    todoListCollectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
    if let layout = calenderCollectView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionHeadersPinToVisibleBounds = true
    }
    [calenderCollectView,todoListCollectionView]
      .forEach{
      $0?.delegate = calenderDataSource
      $0?.dataSource = calenderDataSource
    }
  }

}

extension ViewController{

  fileprivate func switchArrow(_ sender: UIButton) {
    switch sender.currentTitle?.hasSuffix("▲"){
    case true:  sender.setTitle("September ▼", for: .normal)
    case false: sender.setTitle("September ▲", for: .normal)
    default:    break
    }
  }

  @IBAction func titleTapped(_ sender: UIButton) {
    switchArrow(sender)
  }
}

extension ViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionView.tag == 0 ? a1.count : a2.count
  }

  fileprivate func makeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCollectionViewCell
    cell.titleLabel.text = "\(collectionView.tag == 0 ? a1[indexPath.item] : a2[indexPath.item])"
    cell.titleLabel.backgroundColor = .red
    cell.titleLabel.layer.cornerRadius = cell.titleLabel.bounds.width / 2
    cell.titleLabel.clipsToBounds = true
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return makeCell(collectionView, indexPath)
  }

}

extension ViewController:UICollectionViewDelegate{

}


