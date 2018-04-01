//
//  FavoriteViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/03/31.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit

protocol FavoritePresenter: class {
  init(view: FavoriteView)
  var numberOfFavorites: Int { get }
  func addFavorite(_ repository: GithubKit.Repository)
  func removeFavorite(_ repository: GithubKit.Repository)
  func favoriteRepository(at index: Int) -> GithubKit.Repository
  func showFavoriteRepository(at index: Int)
  func contains(_ repository: GithubKit.Repository) -> Bool
}

final class FavoriteViewPresenter: FavoritePresenter {
  private var view: FavoriteView
  // お気に入りの一覧を保持しているfavorites: [GithubKit.Repository]が更新されると以下を実行
  private var favorites: [GithubKit.Repository] = [] {
    didSet {
      view.reloadData()
    }
  }
  
  init(view: FavoriteView) {
    self.view = view
  }
  
  // お気に入り登録しているrepositoryの数を返す
  var numberOfFavorites: Int {
    return favorites.count
  }
  
  // お気に入り登録しているところから指定のRepositoryを検索する
  func addFavorite(_ repository: GithubKit.Repository) {
    if favorites.lazy.index(where: { $0.url == repository.url }) != nil {
      return
    }
    favorites.append(repository)
  }
  
  // お気に入り登録しているところから指定のRepositoryを検索する
  func removeFavorite(_ repository: GithubKit.Repository) {
    guard let index = favorites.lazy.index(where: { $0.url == repository.url}) else {
      return
    }
    favorites.remove(at: index)
  }
  
  // お気に入り登録しているところから指定の配列番号のrepositoryを返す
  func favoriteRepository(at index: Int) -> GithubKit.Repository {
    return favorites[index]
  }
  
  // お気に入り登録しているところから指定の配列番号のrepositoryの画面を表示
  func showFavoriteRepository(at index: Int) {
    let repository = favorites[index]
    view.showRepository(with: repository)
  }
  
  // お気に入り登録しているところから指定のRepositoryが含まれているかチェック
  func contains(_ repository: GithubKit.Repository) -> Bool {
    //  含まれていたらtrueを返す
    return favorites.lazy.index { $0.url == repository.url } != nil
  }
}
