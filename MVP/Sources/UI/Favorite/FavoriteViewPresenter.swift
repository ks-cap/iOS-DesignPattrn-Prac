//
//  FavoriteViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/03/31.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit

protocol FavoritePresenter: class {
  init(view: FavoriteView) 
}

class FavoriteViewPresenter: FavoritePresenter {
  private var view: FavoriteView
  
  init(view: FavoriteView) {
    self.view = view
  }

}
