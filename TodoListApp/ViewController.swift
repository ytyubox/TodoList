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
  @IBAction func titleTapped(_ sender: UIButton) {
    sender.switchArrow()
  }
}
