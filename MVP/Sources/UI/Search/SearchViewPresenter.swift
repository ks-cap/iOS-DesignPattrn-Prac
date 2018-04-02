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
   debounce
    - 前回のイベント発生後から
    - 一定時間内に同じイベントが発生するごとに処理の実行を一定時間遅延させ,
    - 一定時間イベントが発生しなければ処理を実行する.
   ⬇︎
   サーバー負荷なども考慮して, APIを叩く頻度を絞ったりすることが可能
   */
  private let debounce: (_ action: @escaping () -> ()) -> () = {
    // 前回に実行された時間を保持するlastFireTimeを定義し、現在の時刻を代入
    var lastFireTime: DispatchTime = .now()
    // 遅延時間
    let delay: DispatchTimeInterval = .microseconds(500)
    
    return { [delay] action in
      let deadline: DispatchTime = .now() + delay
      // lastFireTimeに現在時刻を再代入(throttleとの違い)
      lastFireTime = .now()
      // グローバルキューは現在実行中の処理の終了を待たずに次の処理を並列して実行する (引数の記述がない際global(qos: .default)）
      DispatchQueue.global().asyncAfter(deadline: deadline) { [delay] in
        // 現在時刻と最後に実行された時刻+delayの時刻を比較
        let now: DispatchTime = .now()
        let when: DispatchTime = lastFireTime + delay
        // 現在時刻の方が進んでいた場合に、lastFireTimeを更新し、引数で受け取っていたactionを実行
        if now < when { return }
        lastFireTime = .now()
        DispatchQueue.main.async {
          action()
        }
      }
    }
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
