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
    
    tableView.register(GithubKit.UserViewCell.self)
    tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.className)
  }
}

extension SearchViewDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // 検索でヒットしたユーザ数を返す
    return presenter.numberOfUsers
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(GithubKit.UserViewCell.self, for: indexPath)
    // ユーザ情報を取得
    let user = presenter.user(at: indexPath.row)
    cell.configure(with: user)
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: UITableViewHeaderFooterView.className) else {
      return nil
    }
    presenter.showLoadingView(on: view)
    return view
  }
}

extension SearchViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    <#code#>
  }
}
