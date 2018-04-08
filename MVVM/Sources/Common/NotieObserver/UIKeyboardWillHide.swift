//
//  UIKeyboardWillHide.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/08.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import NoticeObserveKit

struct UIKeyboardWillHide: NoticeType {
  typealias InfoType = UIKeyboardInfo
  static let name: Notification.Name = .UIKeyboardWillHide
}
