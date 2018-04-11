//
//  FavoriteViewController.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/09.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit
import RxSwift
import RxCocoa

final class FavoriteViewController: UIViewController {
  
  var favoritesInput: AnyObserver<[GithubKit.Repository]> { return favorites.asObserver() }
  var favoritesOutput: Observable<[GithubKit.Repository]> { return viewModel.favorites }
  
  private lazy var dataSource: FavoriteViewDataSource = .init(viewModel: self.viewModel)
  
  private private(set) lazy var viewModel: FavoriteViewModel = {
    /*
     FavoriteViewDataSourceから送られてきたObservable型変数をviewModelに流す
     (そのために必要な処理"bind"をviewDidLoad内で行っている)
     */
    .init(selectedIndexPath: self.selectedIndexPath)
  }()
  
  private let selectedIndexPath = PublishSubject<IndexPath>()
  
  private let favorites = PublishSubject<[GithubKit.Repository]>()
  private let disposebag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // ---- viewとviewModelをbind ----
    
    // dataSourceからのイベントをviewModelに流すための処理
    dataSource.selectedIndexPath
      .bind(to: selectedIndexPath)
      .disposed(by: disposebag)
    
    // viewModel内の変数とshowRepositoryをbindする
    viewModel.selectedRepository
      .bind(to: showRepository)
      .disposed(by: disposebag)
    
    // ------------------------------
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // RepositoryViewControllerに遷移
  private var showRepository: AnyObserver<GithubKit.Repository> {
    return UIBindingObserver(UIElement: self) { me, repository in
      let vc = RepositoryViewController(...)
      me.navigationController?.pushViewController(vc, animated: true)
      }.asObserver()
  }
  
}
