//
//  TodoCollectionViewCell.swift
//  TodoListApp
//
//  Created by 游宗諭 on 2019/3/18.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class TodoCollectionViewCell: UICollectionViewCell {
  @IBOutlet var textView: UITextView!
  @IBOutlet var indacatorView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        indacatorView.layer.cornerRadius = indacatorView.bounds.width / 2
    indacatorView.clipsToBounds = true
    }
  var todo:Todo! {
    didSet{
      handleTodo()
    }
  }

}

extension TodoCollectionViewCell{
}

extension TodoCollectionViewCell{
  private func makeContent()->NSAttributedString{
    let re = NSMutableAttributedString()
    let dot = "●".makeDot(type: todo!.type)
    let text = ("\t\t" + todo.title).titleText
    let descript = ("\n\t\t" + (todo.description  ?? "")).descriptionText
    [dot,text,descript].compactMap{$0}.forEach{re.append($0)}
    return re


  }
  private func handleTodo(){
    indacatorView.backgroundColor = todo.type.color
    textView.attributedText = makeContent()
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
