//
//  RepositoryViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import GithubKit

protocol RepositoryPresenter: class {
  init(repository: GithubKit.Repository, favoritePresenter: FavoritePresenter)
  var view: RepositoryView { get set }
  var favoriteButtonTitle: String { get }
  func favoriteButtonTap()
}

class RepositoryViewPresenter: RepositoryPresenter {
  var view: RepositoryView
  private let favoritePresenter: FavoritePresenter
  private let repository: GithubKit.Repository
  
  required init(repository: GithubKit.Repository, favoritePresenter: FavoritePresenter) {
    self.repository = repository
    self.favoritePresenter = favoritePresenter
  }
  
  // UINavigationItemに表示する文字を選択
  var favoriteButtonTitle: String {
    return favoritePresenter.contains(repository) ? "Remove" : "Add"
  }
  
  func favoriteButtonTap() {
    // お気に入り登録の追加や削除とUINavigationItemに表示する文字を表示する処理をfavoritePresenterに委譲する
    if favoritePresenter.contains(repository) {
      favoritePresenter.removeFavorite(repository)
      view.updateFavoriteButtonTitle(favoriteButtonTitle)
    } else {
      favoritePresenter.addFavorite(repository)
      view.updateFavoriteButtonTitle(favoriteButtonTitle)
    }
  }
}
