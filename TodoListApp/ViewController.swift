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
  @IBOutlet var newButton: UIButton!
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
    let ges = UITapGestureRecognizer(target: self, action: #selector(handletap))
    calenderCollectView.addGestureRecognizer(ges)
    calenderCollectView.isUserInteractionEnabled = true
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    titlebutton.setTitle(Date().month + " ▼", for: .normal)
    calendarHeight.constant = 30
  }

}

extension ViewController{
  @IBAction
  private func titleTapped(_ sender: UIButton) {
    performSelector(onMainThread: #selector(handletap), with: nil, waitUntilDone: false)
//    sender.switchArrow()

  }

  @objc
  private func handletap(){
    titlebutton.switchArrow()
    var offset:CGFloat
    switch  titlebutton.currentTitle!.hasSuffix("▼") {
    case true:
      offset = 1
    case false:
      let count = calenderDataSource.days.count
      offset = CGFloat((count / 7) + (count % 7 == 0 ?  0 : 1))
    }
    calendarHeight.constant = offset  * 30
    view.layoutIfNeeded()
    calenderCollectView.reloadData()
  }
}
