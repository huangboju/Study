//
//  ViewController.swift
//  LockStudy
//
//  Created by 黄伯驹 on 2017/7/12.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

// http://www.jianshu.com/p/6773757a6cd5
// https://juejin.im/post/57f6e9f85bbb50005b126e5f

// http://www.jianshu.com/p/ddbe44064ca4

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        conditionLock()

//        semaphore()
        
//        nslock()
        
//        nsrecursiveLock()
        
        nscondition()
    }
    
    func nscondition() {
        let condition = NSCondition()
        
        var products: [String] = []
        
        DispatchQueue.global().async {
            
            while true {
                condition.lock()
                if products.isEmpty {
                    print("wait for product")
                    condition.wait() // 让当前线程处于等待状态
                }
                products.remove(at: 0)
                print("custome a product")
                condition.unlock()
            }
            
        }
        
        DispatchQueue.global().async {
            while true {
                condition.lock()

                products.append("aaaa")
                print("produce a product,总量:\(products.count)")
                condition.signal() // CPU发信号告诉线程不用在等待，可以继续执行

                condition.unlock()
                sleep(1)
            }
        }
    }
    
    func nsrecursiveLock() {
        let lock = NSRecursiveLock()
        var recursiveMethod: ((Int) -> Void)?
        DispatchQueue.global().async {
            recursiveMethod = { value in
                lock.lock()
                if value > 0 {
                    print("value = \(value)")
                    sleep(1)
                    recursiveMethod?(value - 1)
                }
                lock.unlock()
            }
            recursiveMethod?(5)
        }
    }
    
    
    func nslock() {
        let lock = NSLock()
        DispatchQueue.global().async {
            let flag = lock.lock(before: Date()) // 会在所指定Date之前尝试加锁，如果在指定时间之前都不能加锁，则返回NO
            print("需要线程同步的操作1 开始")
            sleep(2)
            print("需要线程同步的操作1 结束")
            lock.unlock()
        }

        DispatchQueue.global().async {
            sleep(1);

            if lock.try() { //尝试获取锁，如果获取不到返回NO，不会阻塞该线程
                print("锁可用的操作")
                lock.unlock()
            } else {
                print("锁不可用的操作")
            }
 
            let date = Date(timeIntervalSinceNow: 3)
            if lock.lock(before: date) { //尝试在未来的3s内获取锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
                print("没有超时，获得锁")
                lock.unlock()
            }else{
                print("超时，没有获得锁")
            }
            
        }
    }
    
    func semaphore() {
        let signal = DispatchSemaphore(value: 1)
        let overTime = DispatchTime.now() + 3
        DispatchQueue.global().async {
            signal.wait(timeout: overTime)
            print("需要线程同步的操作1 开始")
            sleep(2)
            print("需要线程同步的操作1 结束")
            signal.signal()
        }
        
        DispatchQueue.global().async {
            sleep(1)
            signal.wait(timeout: overTime)
            print("需要线程同步的操作2")
            signal.signal()
        }
    }
    
    // 自旋锁
    func pthread_mutexattr() {
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)  // 定义锁的属性
        
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, &attr) // 创建锁

        pthread_mutex_lock(&mutex) // 申请锁
        // 临界区
        pthread_mutex_unlock(&mutex) // 释放锁
    }

    func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
        objc_sync_enter(lock)
        defer { objc_sync_exit(lock) }
        return try body()
    }

    func conditionLock() {
        let cLock = NSConditionLock(condition: 0)
        
        //线程1
        DispatchQueue.global().async {
            
            if cLock.tryLock(whenCondition: 0) {
                print("线程1")
                cLock.unlock(withCondition: 1)
            }else{
                print("失败")
            }
        }
        
        //线程2
        DispatchQueue.global().async {
            cLock.lock(whenCondition: 1)
            print("线程2")
            cLock.unlock(withCondition: 3)
        }

        //线程3
        DispatchQueue.global().async {
            cLock.lock(whenCondition: 3)
            print("线程3")
            cLock.unlock(withCondition: 2)
        }
    }

}

