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
  // _favoritesのイベントを外部に公開するために利用
  let favorites: Observable<[GithubKit.Repository]>
  // イベントを外部に公開
  let selectRepository: Observable<[GithubKit.Repository]>
  
  private let _favorites = BehaviorSubject<[GithubKit.Repository]>(value: [])
  
  init(selectedIndexPath: Observable<IndexPath>) {
    self.favorites = _favorites.asObservable()
    // 最新の状態をwithLatestFromで取得し、配列内で該当するrowのRepositoryを返す
    self.selectRepository = selectedIndexPath
        .withLatestFrom(_favorites.asObservable()) { $1[$0.row] }
  }
}
