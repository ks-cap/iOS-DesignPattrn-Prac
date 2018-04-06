//
//  UserRepositoryViewDataSource.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/06.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import UIKit
import GithubKit

final class UserRepositoryViewDataSource: NSObject {
  
  // 自身のPresenterを保持
  fileprivate let presenter: UserRepositoryPresenter
  
  init(presenter: UserRepositoryPresenter) {
    self.presenter = presenter
  }
  
  // tableViewの設定
  func configure(with tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(RepositoryViewCell.self)
    tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.className)
  }
  
}

extension UserRepositoryViewDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberOfRepositories
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(RepositoryViewCell.self, for: indexPath)
    let repository = presenter.repository(at: indexPath.row)
    cell.configure(with: repository)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableCell(withIdentifier: UITableViewHeaderFooterView.className) else {
      return nil
    }
    presenter.showLoadingView(on: view)
    return view
  }
  
}

extension UserRepositoryViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    presenter.showRepository(at: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let repository = presenter.repository(at: indexPath.row)
    return RepositoryViewCell.calculateHeight(with: repository, and: tableView)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return presenter.isFetchingRepositories ? LoadingView.defaultHeight : .leastNormalMagnitude
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let maxScrollDistance = max(0, scrollView.contentSize.height - scrollView.bounds.size.height)
    presenter.setIsReachedBottom(maxScrollDistance <= scrollView.contentOffset.y)
  }
}

