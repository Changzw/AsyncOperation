//
//  FetchDataOperation.swift
//  AsyncOperation
//
//  Created by czw on 8/5/20.
//  Copyright © 2020 czw. All rights reserved.
//

import UIKit

protocol DataProviding {
  var data: Any? { get }
}

class FetchDataOperation: AsyncOperation {

  private var data_: [Int]!
  
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
  
  override func main() {
    if isCancelled {
      finish()
      return
    }
    
    DispatchQueue.global().async {
      sleep(2)
      self.data_ = [1,2,3]
      self.finish()
    }
  }
}

extension FetchDataOperation: DataProviding {
  var data: Any?{
    return data_
  }
}
