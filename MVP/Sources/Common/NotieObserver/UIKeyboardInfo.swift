//
//  UIKeyboardInfo.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import NoticeObserveKit

struct UIKeyboardInfo: NoticeUserInfoDecodable {
  let frame: CGRect
  let animationDuration: TimeInterval
  let animationCurve: UIViewAnimationOptions
  
  init?(info: [AnyHashable : Any]) {
    guard
      let frame = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
      let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
      let curve = info[UIKeyboardAnimationCurveUserInfoKey] as? UInt
      else { return nil }
    self.frame = frame
    self.animationDuration = duration
    self.animationCurve = UIViewAnimationOptions(rawValue: curve)
  }
}
