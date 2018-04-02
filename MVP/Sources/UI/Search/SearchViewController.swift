//
//  SearchViewController.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit

protocol SearchView: class {
  func reloadData()
  func KeyboardWillShow(with keyboardInfo: UIKeyboardInfo)
  func KeyboardWillHide(with keyboardInfo: UIKeyboardInfo)
  func showUserRepository(with user: GithubKit.User)
  func updateTotalCountLabel(_ countText: String)
  func updateLoadingView(with view: UIView, isLoading: Bool)
  func showEmptyTokenError()
}

final class SearchViewController: UIViewController, SearchView {
  @IBOutlet weak var totalCountLabel: UILabel!
  @IBOutlet weak var searchTableView: UITableView!
  @IBOutlet weak var searchTableViewBottomConstraint: NSLayoutConstraint!
  
  private (set) lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = self
    return searchBar
  }()
  
  // ロード画面に表示するactivityIndicator
  fileprivate let loadingView = LoadingView.makeFromNib()
  // FavoritePresenterを参照
  private let favoritePresenter: FavoritePresenter?
  // 自身のpresenterを保持
  private lazy var presenter: SearchPresenter = SearchViewPresenter(view: self)
  // 自身のdataSourceを保持
  private lazy var dataSource: SearchViewDataSource = .init(presenter: self.presenter)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.titleView = searchBar
    searchBar.placeholder = "Input user name"
    
    dataSource.configure(with: searchTableView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if searchBar.isFirstResponder {
      // キーボードを非表示
      searchBar.resignFirstResponder()
    }
    presenter.viewWillDisappear()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func reloadData() {
    searchTableView.reloadData()
  }
  
  func KeyboardWillShow(with keyboardInfo: UIKeyboardInfo) {
    view.layoutIfNeeded()
    let extra = tabBarController?.tabBar.bounds.height ?? 0
    searchTableViewBottomConstraint.constant = keyboardInfo.frame.size.height - extra
    UIView.animate(withDuration: keyboardInfo.animationDuration,
                   delay: 0,
                   options: keyboardInfo.animationCurve,
                   animations: { self.view.layoutIfNeeded() },
                   completion: nil)
  }
  
  func KeyboardWillHide(with keyboardInfo: UIKeyboardInfo) {
    view.layoutIfNeeded()
    searchTableViewBottomConstraint.constant = 0
    UIView.animate(withDuration: keyboardInfo.animationDuration,
                   delay: 0,
                   options: keyboardInfo.animationCurve,
                   animations: { self.view.layoutIfNeeded() },
                   completion: nil)
  }
  
  // 画面遷移
  func showUserRepository(with user: User) {
    guard let presenter = favoritePresenter else { return }
//    let vc = User
    // 画面を遷移
//    navigationController?.pushViewController(vc, animated: true)
  }
  
  func updateTotalCountLabel(_ countText: String) {
    totalCountLabel.text = countText
  }
  
  func updateLoadingView(with view: UIView, isLoading: Bool) {
    loadingView.removeFromSuperview()
    loadingView.isLoading = isLoading
    loadingView.add(to: view)
  }
  
  func showEmptyTokenError() {
    let alert = UIAlertController(title: "Access Token Error",
                                  message: "\"Github Personal Access Token\" is Required.\n Please set it in ApiSession.extension.swift!",
                                  preferredStyle: .alert)
    present(alert, animated: false, completion: nil)
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    presenter.search(queryIfNeeded: searchText)
  }
}
