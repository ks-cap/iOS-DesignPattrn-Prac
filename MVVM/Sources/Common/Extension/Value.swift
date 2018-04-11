//
//  Value.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/09.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation

struct Value<Base> {
  let base: Base
}

protocol ValueCompatible {
  var value: Value<Self> { get }
}

extension ValueCompatible {
  var value: Value<Self> {
    return Value(base: self)
  }
}

