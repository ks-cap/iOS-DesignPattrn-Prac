//
//  RepositoryViewModel.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/11.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import GithubKit
import RxSwift
import RxCocoa

final class RepositoryViewModel {
  private let disposeBag = DisposeBag()
  
  // favoriteOutput: お気に入り一覧の配列の更新イベントを受け取る.
  init(repository: GithubKit.Repository,
       favoritesOutput: Observable<[GithubKit.Repository]>,
       favoritesInput: AnyObserver<[GithubKit.Repository]>,
       favoriteButtonTap: RxCocoa.ControlEvent<Void>) {
    /*
     ViewModelで保持しているGithubKit.Repositoryが渡ってきた配列 "[repository]" に
     含まれている場合は配列と該当するindexを返し、含まれていなかった場合は配列とnilを返す.
     */
    let favoritesAndIndex = favoritesOutput
      .map { [repository] favorites in
        (favorites, favorites.index(where: { $0.url == repository.url }))
    }
    
    // ControlEvent<Void>のイベントを受け取った際に上記の最新状態をwithLatestFromで受け取る
    favoriteButtonTap
      .withLatestFrom(favoritesAndIndex)
      .map { [repository] favorites, index in
        var favorites = favorites
        if let index = index {
          // 該当のindexを削除した状態の配列返す
          favorites.remove(at: index)
          return favorites
        }
        // ViewModelが保持しているGithubKit.Repositoryを追加した配列を返す.
        favorites.append(repository)
        return favorites
      }
      // favoritesInput: AnyObserver<[GithubKit.Repository]>にその配列を流す.
      .subscribe(onNext: { favoritesInput.onNext($0) })
      .disposed(by: disposeBag)
  }
}
