//
//  ViewController.swift
//  CopyOnWrite
//
//  Created by 黄伯驹 on 2017/9/6.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let numbers = [30, 40, 20, 30, 30, 60, 10]
        let b = [30, 40, 20]

        let p = numbers.split(separator: 30)
        print(p)
        
        let  bsSequence = AnySequence(bsIterator)
        let array = Array(bsSequence.prefix(10))
        print(array)
        

        
        let  bsSequence2 = sequence(state: (0, 1)) {
            // 在这里编译器需要一些类型推断的协助 
            (state: inout (Int, Int)) -> Int? in
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
        let c = Array(bsSequence2.prefix(10))
        print(c)
    }
    
    func  bsIterator() -> AnyIterator<Int> {
        var state = (0, 1)
        return AnyIterator {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

