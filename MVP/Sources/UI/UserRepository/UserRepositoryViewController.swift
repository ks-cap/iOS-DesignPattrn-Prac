//
//  UserRepositoryViewController.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/03.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit

protocol UserRepositoryView: class {
  func reloadData()
  func showRepository(with repository: GithubKit.Repository)
  func updateTotalCount(_ countText: String)
  func updateLoadingView(with view: UIView, isLoading: Bool)
}

class UserRepositoryViewController: UIViewController, UserRepositoryView {

  @IBOutlet weak var repositoryTableView: UITableView!
  @IBOutlet weak var totalCountLabel: UILabel!
  
  // ロード画面に表示するactivityIndicator
  private let loadingView = LoadingView.makeFromNib()
  // FavoritePresenterを参照
  private let favoritePresenter: FavoritePresenter
  
  init(user: GithubKit.User, favoritePresenter: FavoritePresenter) {
    self.favoritePresenter = favoritePresenter
    super.init(nibName: UserRepositoryViewController.className, bundle: nil)
    hidesBottomBarWhenPushed = true
    
  }

  required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
  }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  func reloadData() {
    repositoryTableView.reloadData()
  }
  
  func showRepository(with repository: Repository) {
    // レポジトリ詳細画面に遷移
    let vc = RepositoryViewController(repository: repository, favoritePresenter: favoritePresenter)
    navigationController?.pushViewController(vc, animated: true)
  }
  func updateTotalCount(_ countText: String) {
    self.totalCountLabel.text = countText
  }
  
  func updateLoadingView(with view: UIView, isLoading: Bool) {
    loadingView.removeFromSuperview()
    loadingView.isLoading = isLoading
    loadingView.add(to: view)
  }
}
