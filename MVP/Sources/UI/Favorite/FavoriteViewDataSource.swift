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
  fileprivate let presenter: FavoritePresenter
  
  init(presenter: FavoritePresenter) {
    self.presenter = presenter
  }
  
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
    let repository = presenter.
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
    presenter
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let repository = presenter
  }
}
