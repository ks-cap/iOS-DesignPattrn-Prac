//
//  FavoriteViewDataSource.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/09.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import UIKit
import GithubKit
import RxSwift

final class FavoriteViewDataSource: NSObject {
  // 外部に公開 (viewControllerにてdataSourceとviewModelをbind)
  let selectedIndexPath: Observable<IndexPath>
  
  // テーブルビューのセルを押したときに反応
  private let _selectedIndexPath = PublishSubject<IndexPath>()
  
  // 自身のviewModelを持つ
  private let viewModel: FavoriteViewModel
  
  init(viewModel: FavoriteViewModel) {
    self.viewModel = viewModel
    self.selectedIndexPath = _selectedIndexPath
  }
  
  func configure(with tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(GithubKit.RepositoryViewCell.self)
  }
}

extension FavoriteViewDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.value.favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(GithubKit.RepositoryViewCell.self, for: indexPath)
    let repository = viewModel.value.favorites[indexPath.row]
    cell.configure(with: repository)
    
    return cell
  }
}

extension FavoriteViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    _selectedIndexPath.onNext(indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let repository = viewModel.value.favorites[indexPath.row]
    return RepositoryViewCell.calculateHeight(with: repository, and: tableView)
  }
}
