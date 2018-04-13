//
//  FavoriteViewModel.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/09.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit
import RxSwift
import RxCocoa

final class FavoriteViewModel {
  // (_favoritesを)外部に公開
  let relaodData: Observable<Void>
  
  // _favoritesのイベントを外部に公開するために利用
  let favorites: Observable<[GithubKit.Repository]>
  // 配列内で該当するrowのRepositoryを返すイベントを外部に公開 (viewModel内の関数であるshowRepositoryとbindされている)
  let selectedRepository: Observable<GithubKit.Repository>
  
  let _favorites = BehaviorSubject<[GithubKit.Repository]>(value: [])
  
  let disposeBag = DisposeBag()
  
  /*
   favoritesObservable: Observable<[GithubKit.Repository]>を利用して外部からのイベントを受け取る.
   FavoriteViewDataSourceから送られてきたObservable型変数"selectedIndexPath: Observable<IndexPath>"を
   FavoriteViewModel内のinputとして、initializerの引数として受け取る.
   */
  init(favoritesObservable: Observable<[GithubKit.Repository]>,
    selectedIndexPath: Observable<IndexPath>) {
    
     // _favoritesが更新されたイベントをObservable<Void>に変換.
    self.favorites = _favorites.asObservable()
    self.relaodData = _favorites.asObservable().map { _ in }
    
    /* selectedIndexPathからイベントが渡ってくると,
     最新の状態をwithLatestFromで取得し, 配列内で該当するrowのRepositoryを返す.
     */
    self.selectedRepository = selectedIndexPath
      .withLatestFrom(_favorites.asObservable()) { $1[$0.row] }
    
    // favoritesObservableを_favoritesにbindして、保持している配列を更新.
    favoritesObservable
    .bind(to: _favorites)
    .disposed(by: disposeBag)
  }
}

extension FavoriteViewModel: ValueCompatible {}

extension Value where Base == FavoriteViewModel {
  var favorites: [GithubKit.Repository] {
    return try! base._favorites.value()
  }
}
