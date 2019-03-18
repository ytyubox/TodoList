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

}
