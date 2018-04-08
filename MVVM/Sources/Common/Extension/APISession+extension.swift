//
//  APISession+extension.swift
//  MVVM
//
//  Created by 佐藤賢 on 2018/04/08.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import GithubKit

extension ApiSession {
  static let shared: ApiSession = {
    let token = "" // <- Your Github Personal Access Token
    return ApiSession(injectToken: { InjectableToken(token: token) })
  }()
}
