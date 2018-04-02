//
//  SearchViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit

protocol SearchPresenter {
  init(view: SearchView)
  var numberOfUsers: Int { get }
  var isFetchingUsers: Bool { get }
  func user(at index: Int) -> User
  func search(queryIfNeeded query: String)
  func showUser(at index: Int)
  func setIsReachedBottom(_ isReachedBottom: Bool)
  func showLoadingView(on view: UIView)
}

final class SearchViewPresenter: SearchPresenter {
  private var view: SearchView
  private var task: URLSessionTask? = nil
  private var pageInfo: GithubKit.PageInfo? = nil
  
  private var query: String = "" {
    didSet {
      // 更新されたら
      if query != oldValue {
        users.removeAll()
        pageInfo = nil
        totalCount = 0
      }
      task?.cancel()
      task = nil
      fetchUsers()
    }
  }
  
  
  required init(view: SearchView) {
    self.view = view
  }
  
  // 検索結果のユーザ数
  private var totalCount: Int = 0 {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view.updateTotalCountLabel("\(strongSelf.users.count)/\(strongSelf.totalCount)")
        strongSelf.view.reloadData()
      }
    }
  }
  
  // 検索結果のユーザ情報
  private var users: [GithubKit.User] = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view.updateTotalCountLabel("\(strongSelf.users.count)/\(strongSelf.totalCount)")
        strongSelf.view.reloadData()
      }
    }
  }
  
  private var isReachedBottom: Bool = false {
    didSet {
      if isReachedBottom && isReachedBottom != oldValue {
        
      }
    }
  }
  
  /*
   前回のイベント発生後から
   一定時間内に同じイベントが発生するごとに処理の実行を一定時間遅延させ,
   一定時間イベントが発生しなければ処理を実行する.
   */
  private let debounce: (_ action: @escaping () -> ()) -> () = {
    // 前回に実行された時間を保持
    var lastFireTime: DispatchTime = .now()
    
  }()
  
  var isFetchingUsers = false {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.view.reloadData()
      }
    }
  }
  
  
  var numberOfUsers: Int {
    return users.count
  }
  
  func user(at index: Int) -> User {
    return users[index]
  }
  
  // 検索するためのクエリ文字を抽出
  func search(queryIfNeeded query: String) {
    <#code#>
  }
  private func fetchUsers() {
    
  }
  
  func showUser(at index: Int) {
    let user = users[index]
    view.showUserRepository(with: user)
  }
  
  func setIsReachedBottom(_ isReachedBottom: Bool) {
    self.isReachedBottom = isReachedBottom
  }
  
  func showLoadingView(on view: UIView) {
    self.view.updateLoadingView(with: view, isLoading: isFetchingUsers)
  }
}
