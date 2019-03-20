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
            var calenderDataSource = CalendarDataSource()
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
    newButton.layer.cornerRadius = newButton.frame.height / 2
    calenderCollectView.isPagingEnabled = true
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    titlebutton.setTitle(Date().month + " ▼", for: .normal)
    calendarHeight.constant = 30
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scroll(true)
  }

}

extension ViewController{
  @IBAction
  private func titleTapped(_ sender: UIButton) {
    performSelector(onMainThread: #selector(handletap), with: nil, waitUntilDone: false)
//    sender.switchArrow()

  }

  @IBAction func AddnewTodo(_ sender: UIButton){
    calenderDataSource.todos.append(Todo(title: "a", type: .blue))
    todoListCollectionView.reloadData()
  }


  fileprivate func scroll(_ bool: Bool) {
    var index = 0
    if bool{
      let d = Date()
      index =  d.monthDay + d.firstDayofMonth.weekDay
    }
    calenderCollectView.scrollToItem(at: .init(item: index, section: 0), at: [.top,], animated: !bool)
  }

  @objc
  private func handletap(){
    titlebutton.switchArrow()
    let bool = titlebutton.currentTitle!.hasSuffix("▼")

    var offset:CGFloat
    switch   bool{
    case true:
      offset = 1
    case false:
      let count = calenderDataSource.days.count
      offset = CGFloat((count / 7) + (count % 7 == 0 ?  0 : 1))
      break
    }
    calendarHeight.constant = offset  * 30

    view.layoutIfNeeded()
    scroll(bool)
    calenderCollectView.reloadData()
  }
}
