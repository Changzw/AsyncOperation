//
//  CompleteOperation.swift
//  AsyncOperation
//
//  Created by czw on 8/5/20.
//  Copyright © 2020 czw. All rights reserved.
//

import UIKit

class CompleteOperation: Operation {

  var data: Any?
  
  
  override init() {
    super.init()
    addObserver(self, forKeyPath: "isFinished", options: .new, context: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    print("keypath:\(keyPath) \n obj:\(object)\n change:\(change)")
  }
  
  deinit {
    removeObserver(self, forKeyPath: "isFinished")
  }
  
  override func start() {
    data = dependencies.compactMap({ (o) -> Any? in
      return (o as? DataProviding)?.data
      }).first
    super.start()
  }
}
