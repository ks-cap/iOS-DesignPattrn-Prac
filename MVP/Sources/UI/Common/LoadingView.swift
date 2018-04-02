//
//  LoadingView.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/02.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import GithubKit

final class LoadingView: UIView, Nibable {
  
  typealias RegisterType = RegisterNib
  static let defaultHeight: CGFloat = 44
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var isLoading: Bool = false {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.activityIndicator.isHidden = !strongSelf.isLoading
        if strongSelf.isLoading {
          strongSelf.activityIndicator.startAnimating()
        } else {
          strongSelf.activityIndicator.stopAnimating()
        }
      }
    }
  }
  
  func add(to view: UIView) {
    removeFromSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(self)
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: topAnchor),
      view.leftAnchor.constraint(equalTo: leftAnchor),
      view.rightAnchor.constraint(equalTo: rightAnchor),
      view.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
  }
}
