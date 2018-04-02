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
  
}

class UserRepositoryViewController: UIViewController {

  // ロード画面に表示するactivityIndicator
  private let loadView = LoadingView.makeFromNib()
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

}
