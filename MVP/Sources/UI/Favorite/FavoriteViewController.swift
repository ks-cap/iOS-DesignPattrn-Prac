//
//  FavoriteViewController.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/03/31.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit

protocol FavoriteView: class {
  func reloadData()
  func showRepository(with repository: Repository)
}

final class FavoriteViewController: UIViewController, FavoriteView {
  
  @IBOutlet weak var favoriteTableView: UITableView!
  
  private lazy var presenter: FavoritePresenter = FavoriteViewPresenter(view: self)
  private lazy var dataource: FavoriteViewDataSource = .init(presenter: self.presenter)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "On Memory Favorite"
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func reloadData() {
  }
  
  func showRepository(with repository: Repository) {
  }
}
