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
  // 外部に公開
  private let selectedIndexPath: Observable<IndexPath>
  
  private let _selectedIndexPath: PublishSubject<IndexPath>
  
  // 自身のviewModelを持つ
  private let viewModel: FavoriteViewModel
  
  init(viewModel: FavoriteViewModel) {
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
    return viewModel
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(GithubKit.RepositoryViewCell.self, for: indexPath)
    let repository =
    cell.
    
    return
  }
}

extension FavoriteViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    _selectedIndexPath.onNext(indexPath)
  }
}
