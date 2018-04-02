//
//  FavoriteViewDataSource.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/03/31.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Foundation
import GithubKit

final class FavoriteViewDataSource: NSObject {
  // 自身(Favorite)のPresenterを参照
  fileprivate let presenter: FavoritePresenter
  
  init(presenter: FavoritePresenter) {
    self.presenter = presenter
  }
  
  // tableViewの設定
  func configure(with tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(RepositoryViewCell.self)
  }
}

extension FavoriteViewDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberOfFavorites
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(RepositoryViewCell.self, for: indexPath)
    // お気に入り登録しているところから指定の配列番号のrepositoryを返す
    let repository = presenter.favoriteRepository(at: indexPath.row)
    cell.configure(with: repository)
    
    return cell
  }
}

extension FavoriteViewDataSource: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    // お気に入り登録しているところから指定の配列番号のrepositoryの画面を表示（presenterに委譲）
    presenter.showFavoriteRepository(at: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // お気に入り登録しているところから指定の配列番号のrepositoryを返す
    let repository = presenter.favoriteRepository(at: indexPath.row)
    return RepositoryViewCell.calculateHeight(with: repository, and: tableView)
  }
}
