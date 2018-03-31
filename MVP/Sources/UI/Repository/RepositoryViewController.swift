//
//  RepositoryViewController.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

// GitHubのレポジトリ選択後の画面（Safari）

import UIKit
import SafariServices
import GithubKit

protocol RepositoryView: class {
  func updateFavoriteButtonTitle(_ title: String)
}

final class RepositoryViewController: SFSafariViewController, RepositoryView {
  
  private lazy var favoriteButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(
      title: self.presenter.favoriteButtonTitle,
      style: .plain,
      target: self,
      action: #selector(RepositoryViewController.favoriteButtonTap(_:)))
  }()
  
  private let presenter: RepositoryPresenter
  
  init(repository: Repository,
       favoritePresenter: FavoritePresenter,
       entersReaderIfAvailable: Bool = true) {
    self.presenter = RepositoryViewPresenter(repository: repository,
                                             favoritePresenter: favoritePresenter)
    super.init(url: repository.url, entersReaderIfAvailable: entersReaderIfAvailable)
    hidesBottomBarWhenPushed = true
    self.presenter.view = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = favoriteButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc func favoriteButtonTap(_ sender: UIBarButtonItem) {
    presenter.favoriteButtonTap()
  }
  
  func updateFavoriteButtonTitle(_ title: String) {
    favoriteButtonItem.title = title
  }
  
}
