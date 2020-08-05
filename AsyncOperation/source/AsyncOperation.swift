//
//  AsyncOperation.swift
//  AsyncOperation
//
//  Created by czw on 7/30/19.
//  Copyright © 2020 czw. All rights reserved.
//

import Foundation

open class AsyncOperation: Operation {
  enum State: String {
    case ready, executing, finished
    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }
  
  private let rwlockQueue = DispatchQueue(label: "com.czw.asyncoperation", attributes: .concurrent)
  
  private var _state: State = State.ready
  var state: State {
    get {
      rwlockQueue.sync { return _state }
    }
    
    set {
      willChangeValue(forKey: newValue.keyPath)
      rwlockQueue.sync(flags: .barrier) {
        _state = newValue
      }
      didChangeValue(forKey: state.keyPath)
    }
  }
  
  override open var isReady: Bool {
    return super.isReady && state == .ready
  }
  
  override open var isExecuting: Bool {
    return state == .executing
  }
  
  override open var isFinished: Bool {
    return state == .finished
  }
  
  // When implementing an asynchronous operation object, you must implement this property and return true.
  override open var isAsynchronous: Bool {
    return true
  }
  
  override open func start() {
    if isCancelled {
      state = .finished
      return
    }
    
    main()
    state = .executing
  }

  // call this method at main() async block
  func finish() {
    state = .finished
  }
}
