//
//  ViewController.swift
//  AsyncOperation
//
//  Created by czw on 7/30/20.
//  Copyright © 2020 czw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let a = AsyncOperation()
    let queue = OperationQueue()

    a.addObserver(self, forKeyPath: "isReady", options: .new, context: nil)
    a.addObserver(self, forKeyPath: "isExecuting", options: .new, context: nil)
    a.addObserver(self, forKeyPath: "isFinished", options: .new, context: nil)
    
    queue.addOperations([a], waitUntilFinished: true)
    print("finish")
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    print("keypath:\(keyPath) \n obj:\(object)\n change:\(change)")
  }
}

