//
//  APISession+extension.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import GithubKit

extension ApiSession {
  static let shared: ApiSession = {
    let token = "5ef9d3f29d62e9c32c08aaefa6bfb86bb598dac2" // <- Your Github Personal Access Token
    return ApiSession(injectToken: { InjectableToken(token: token) })
  }()
}
