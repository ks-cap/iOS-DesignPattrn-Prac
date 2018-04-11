//
//  RepositoryViewController.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/11.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit
import RxSwift
import SafariServices

final class RepositoryViewController: SFSafariViewController {
  
  private let favoriteButtonItem: UIBarButtonItem
  private let disposeBag = DisposeBag()
//  private let viewModel: RepositoryViewModel
  
  init(repository: GithubKit.Repository,
       favoriteOutput: Observable<[GithubKit.Repository]>,
       favoriteInput: AnyObserver<[GithubKit.Repository]>) {
    let favoriteButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    self.favoriteButtonItem = favoriteButtonItem
    //    self.viewModel =
    super.init(url: repository.url, entersReaderIfAvailable: true)
  }
  
}
