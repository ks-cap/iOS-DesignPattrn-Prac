
//
//  NSObjectProtocol+extension.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
  static var className: String {
    return String(describing: self)
  }
}
