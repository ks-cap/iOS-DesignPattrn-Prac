//
//  SearchViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation

protocol SearchPresenter {
  init(view: SearchView)
}

class SearchViewPresenter: SearchPresenter {
  private var view: SearchView
  required init(view: SearchView) {
    self.view = view
  }
  
}
