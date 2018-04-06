//
//  UserRepositoryViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/05.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit

protocol UserRepositoryPresenter {
  init(user: User)
  weak var view: UserRepositoryView? { get set }
  var title: String { get }
  var isFetchingRepositories: Bool { get }
  var numberOfRepositories: Int { get }
  func repository(at index: Int) -> GithubKit.Repository
  func showRepository(at index: Int)
  func showLoadingView(on view: UIView)
  func setIsReachedBottom(_ isReachedBottom: Bool)
  func fetchRepositories()
}

// 処理は基本presenter層で行う
class UserRepositoryViewPresenter: UserRepositoryPresenter {
  
  weak var view: UserRepositoryView?
  private let user: User
  
  private var task: URLSessionTask? = nil
  private var pageInfo: GithubKit.PageInfo? = nil
  
  // 一ユーザのレポジトリ一覧
  private var repositories: [GithubKit.Repository] = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view?.updateTotalCountLabel("\(strongSelf.repositories.count) / \(strongSelf.totalCount)")
        strongSelf.view?.reloadData()
      }
    }
  }
  
  // 一ユーザのレポジトリの総数
  private var totalCount: Int = 0 {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view?.updateTotalCountLabel("\(strongSelf.repositories.count) / \(strongSelf.totalCount)")
        strongSelf.view?.reloadData()
      }
    }
  }
  
  // 検索結果を取りに行っているかどうか判別: VC
  private(set) var isFetchingRepositories: Bool = false {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.view?.reloadData()
      }
    }
  }
  
  // tableViewの一番下まで到達したかどうか判断する変数
  private var isReachedBottom: Bool = false {
    didSet {
      if isReachedBottom && isReachedBottom != oldValue {
        fetchRepositories()
      }
    }
  }
  // UserRepositoryVCでUserRepositoryPresenterを保持する際に必要
  required init(user: User) {
    self.user = user
  }
  
  // タイトルを取得: VC
  var title: String {
    return "\(user.login)'s Repositories"
  }
  
  // レポジトリの数を返す: DataSource
  var numberOfRepositories: Int {
    return repositories.count
  }
  
  // 指定の要素のレポジトリを返す: DataSource
  func repository(at index: Int) -> Repository {
    return repositories[index]
  }
  
  // UserRepositoryViewDataSource.swiftのtableViewのdidSelectにより反応
  func showRepository(at index: Int) {
    let repository = repositories[index]
    self.view?.showRepository(with: repository)
  }
  
  func showLoadingView(on view: UIView) {
    self.view?.updateLoadingView(with: view, isLoading: isFetchingRepositories)
  }
  
  func setIsReachedBottom(_ isReachedBottom: Bool) {
    self.isReachedBottom = isReachedBottom
  }
  
  // 一ユーザのレポジトリをAPIを通じて取得: VC
  func fetchRepositories() {
    if task != nil { return }
    if let pageInfo = pageInfo, !pageInfo.hasNextPage || pageInfo.endCursor == nil { return }
    isFetchingRepositories = true
    let request = UserNodeRequest(id: user.id, after: pageInfo?.endCursor)
    //（ApiSessionを拡張(extension)し、sharedにTokenを追加）
    self.task = ApiSession.shared.send(request) { [weak self] in
      switch $0 {
      case .success(let value):
        self?.pageInfo = value.pageInfo
        self?.repositories.append(contentsOf: value.nodes)
        self?.totalCount = value.totalCount
        
      case .failure(let error):
        print(error)
      }
      
      self?.isFetchingRepositories = false
      self?.task = nil
    }
  }
  
}
