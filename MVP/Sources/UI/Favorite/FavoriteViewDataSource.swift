//
//  FavoriteViewDataSource.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/03/31.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit

class FavoriteViewDataSource: NSObject {
  fileprivate let presenter: FavoritePresenter
  
  init(presenter: FavoritePresenter) {
    self.presenter = presenter
  }
}
