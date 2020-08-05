//
//  TransformDataOperation.swift
//  AsyncOperation
//
//  Created by czw on 8/5/20.
//  Copyright © 2020 czw. All rights reserved.
//

import UIKit

class TransformDataOperation<Input, Output>: AsyncOperation where Output: Sequence, Input: Sequence {

  private(set) var input: Input?
  
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
    input = dependencies.compactMap{ (o) in
      return (o as? DataProviding)?.data as? Input
    }.first
    
    super.start()
  }
  
  override func main() {
    if isCancelled {
      finish()
      return
    }
    
    finish()
  }
}

extension TransformDataOperation: DataProviding {
  var data: Any? {
    return input
  }
}
