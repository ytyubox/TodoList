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
  @IBOutlet var weekdayStackView: UIStackView!

            var calendarDataSource = CalendarDataSource()
}

extension ViewController{

  override func viewDidLoad() {
    super.viewDidLoad()
    calenderCollectView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
    todoListCollectionView.register(UINib(nibName: "TodoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodoCell")

    [calenderCollectView,todoListCollectionView]
      .forEach{
        $0?.delegate = calendarDataSource
        $0?.dataSource = calendarDataSource
    }
    let ges = UITapGestureRecognizer(target: self, action: #selector(handletap))
    calenderCollectView.addGestureRecognizer(ges)
    calenderCollectView.isUserInteractionEnabled = true
    newButton.layer.cornerRadius = newButton.frame.height / 2
    calenderCollectView.isPagingEnabled = true
    calendarDataSource.data(for: .get)
    let lpgr =  UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    lpgr.minimumPressDuration = 0.5
    lpgr.delegate = self
    lpgr.delaysTouchesBegan = true
    todoListCollectionView.addGestureRecognizer(lpgr)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    titlebutton.setTitle(Date().month.capitalized + " ▼", for: .normal)
    let weekdayString = DateFormatter.weekdayStrings()
    for (i,x) in weekdayStackView.subviews.enumerated(){
      guard let x = x as? UILabel else {continue}
      x.text = weekdayString[i].filter{$0 != "."}.capitalized
    }

    calendarHeight.constant = 30
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scroll(true)
    print(NSLocale.current.description)
  }

}

var bool = false {
  didSet{
//      UIScreen.main.brightness = bool ? 1 : 0.5

  }
}

extension ViewController{
  @IBAction
  private func titleTapped(_ sender: UIButton) {
    performSelector(onMainThread: #selector(handletap), with: nil, waitUntilDone: false)
//    sender.switchArrow()
    bool.toggle()

  }

  @IBAction func AddnewTodo(_ sender: UIButton){
    calendarDataSource.todos.append(Todo(title: "a", type: .blue))
    todoListCollectionView.reloadData()
    calendarDataSource.data(for: .save)
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
      let count = calendarDataSource.days.count
      offset = CGFloat((count / 7) + (count % 7 == 0 ?  0 : 1))
      break
    }
    calendarHeight.constant = offset  * 30

    view.layoutIfNeeded()
    scroll(bool)
    calenderCollectView.reloadData()
  }
}


var timer:Timer!
var timesUP:Bool = false
var lastGesture:UILongPressGestureRecognizer!

extension ViewController {

  @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
    lastGesture = gesture
    switch gesture.state {
    case .began:
      timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timeUP), userInfo: nil, repeats: false)
      break
    case .ended, .cancelled,.failed:
      timer.invalidate()
    default: break
    }
  }

  @objc func timeUP(){
    print("timeUP")

    let p = lastGesture.location(in: self.todoListCollectionView)

    if let indexPath = self.todoListCollectionView.indexPathForItem(at: p) {
      // get the cell at indexPath (the one you long pressed)
      let cell = self.todoListCollectionView.cellForItem(at: indexPath) as! TodoCollectionViewCell
      print(cell.todo.type)
      let alert = UIAlertController(title: cell.todo.title, message: "", preferredStyle: .alert)
      alert.addTextField(configurationHandler: nil)
      alert.addAction(.init(title: "ok", style: .default, handler: { (_) in
        cell.todo.title = alert.textFields?.first?.text ?? cell.todo.title
      }))
      self.present(alert, animated: true, completion: nil)
    } else {
      print("couldn't find index path")
    }
    timesUP = false
  }
}

extension ViewController:UIGestureRecognizerDelegate{

}
