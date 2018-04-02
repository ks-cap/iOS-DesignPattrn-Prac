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
  
  // 自身のpresenterを保持
  private let presenter: RepositoryPresenter
  
  /*
   presenterのviewがinitializerの引数に含まれていない理由としては,
   repositoryとfavoritePresenterをViewControllerで保持せずに済むようにするため.
   */
  init(repository: GithubKit.Repository,
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
  
  // お気に入りボタンが押された時の処理をpresenterに委譲
  @objc func favoriteButtonTap(_ sender: UIBarButtonItem) {
    presenter.favoriteButtonTap()
  }
  
  // お気に入りボタンに表示する文字をセットする
  func updateFavoriteButtonTitle(_ title: String) {
    favoriteButtonItem.title = title
  }
  
}
