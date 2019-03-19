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
  @IBOutlet var calendarHeight: NSLayoutConstraint!
  var calenderDataSource = CalenderDataSource()
}

extension ViewController{

  override func viewDidLoad() {
    super.viewDidLoad()
    calenderCollectView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
    todoListCollectionView.register(UINib(nibName: "TodoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodoCell")

    [calenderCollectView,todoListCollectionView]
      .forEach{
        $0?.delegate = calenderDataSource
        $0?.dataSource = calenderDataSource
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    titlebutton.setTitle(Date().month + " ▼", for: .normal)
  }

}

extension ViewController{
  @IBAction func titleTapped(_ sender: UIButton) {
    sender.switchArrow()
    calendarHeight.constant = 200
    view.layoutIfNeeded()
  }
}
