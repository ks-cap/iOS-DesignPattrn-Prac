//
//  SearchViewDataSource.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Foundation
import GithubKit

final class SearchViewDataSource: NSObject {
  // 自身(Search)のPresenter
  fileprivate let presenter: SearchPresenter
  
  init(presenter: SearchPresenter) {
    self.presenter = presenter
  }
  
  // tableViewの設定
  func configure(with tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(UserViewCell.self)
    tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.className)
  }
}

extension SearchViewDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberOfUsers
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
  }
}

extension SearchViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    <#code#>
  }
}
