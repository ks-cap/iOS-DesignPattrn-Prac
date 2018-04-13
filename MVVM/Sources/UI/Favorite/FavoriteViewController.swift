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
  
  @IBOutlet weak var tableView: UITableView!
  
  // ------- 以下の2つが遷移する際に、それぞれのViewControllerのinitializerの引数として渡される -------
  // self.favoritesを外部に公開
  var favoritesInput: AnyObserver<[GithubKit.Repository]> { return favorites.asObserver() }
  // viewModel.favoritesを外部に公開
  var favoritesOutput: Observable<[GithubKit.Repository]> { return viewModel.favorites }
  // ---------------------------------------------------------------------------------------
  
  private lazy var dataSource: FavoriteViewDataSource = .init(viewModel: self.viewModel)
  
  private private(set) lazy var viewModel: FavoriteViewModel = {
    /*
     FavoriteViewDataSourceから送られてきたObservable型変数をviewModelに流す
     (そのために必要な処理"bind"をviewDidLoad内で行っている)
     */
    .init(favoritesObservable: self.favorites, selectedIndexPath: self.selectedIndexPath)
  }()
  
  private let selectedIndexPath = PublishSubject<IndexPath>()
  
  private let favorites = PublishSubject<[GithubKit.Repository]>()
  private let disposebag = DisposeBag()
  
  private var reloadData: AnyObserver<Void> {
    return UIBindingObserver(UIElement: self) { me, _ in
      me.tableView.reloadData()
    }.asObserver()
  }
  
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
    
    // FavoriteViewModelで公開されているreloadDataをFavoriteViewControllerのreloadData: AnyObserver<Void>にbind
    viewModel.relaodData
    .bind(to: reloadData)
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
      let vc = RepositoryViewController(repository: repository, favoriteOutput: me.favoritesOutput, favoriteInput: me.favoritesInput)
      me.navigationController?.pushViewController(vc, animated: true)
      }.asObserver()
  }
  
}
