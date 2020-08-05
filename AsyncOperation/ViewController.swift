//
//  ViewController.swift
//  AsyncOperation
//
//  Created by czw on 7/30/20.
//  Copyright © 2020 czw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let fetch = FetchDataOperation()
  let transform = TransformDataOperation<Array<Int>, Array<Int>>()
  let comp = CompleteOperation()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    transform.addDependency(fetch)
    comp.addDependency(transform)
    
    fetch.completionBlock = {
      print("fetch finish")
    }
    transform.completionBlock = {
      print("transform finish")
    }
    comp.completionBlock = {
      print("finish all")
    }
    
    let queue = OperationQueue()
    queue.addOperations([fetch, transform, comp], waitUntilFinished: true)
    
    print("finish")
    print(comp.data)
  }

}

