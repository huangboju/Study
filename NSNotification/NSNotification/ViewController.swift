//
//  ViewController.swift
//  NSNotification
//
//  Created by 伯驹 黄 on 2017/4/4.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

// http://www.jianshu.com/p/3012b863befb

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        NotificationCenter.default.addObserver(self, selector: #selector(handleNotifi), name: NSNotification.Name(rawValue: "Notification"), object: nil)

        notifuQueue()
    }
    
    func handleNotifi(_ notification: Notification) {
        print(notification, Thread.current)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func notifuQueue() {
        
        //每个进程默认有一个通知队列，默认是没有开启的，底层通过队列实现，队列维护一个调度表
        let notifi = Notification(name: Notification.Name(rawValue: "Notification"), object: nil)
        let queue = NotificationQueue.default
        
        
        /*
            whenIdle：空闲发送通知 当运行循环处于等待或空闲状态时，发送通知，对于不重要的通知可以使用。
            asap：尽快发送通知 当前运行循环迭代完成时，通知将会被发送，有点类似没有延迟的定时器。
            now ：同步发送通知 如果不使用合并通知 和postNotification:一样是同步通知。
         */
        
        
        /*
         NSNotificationNoCoalescing：不合并通知。
         NSNotificationCoalescingOnName：合并相同名称的通知。
         NSNotificationCoalescingOnSender：合并相同通知和同一对象的通知。
         */
        
        //FIFO
        print("notifi before")
        queue.enqueue(notifi, postingStyle: .whenIdle, coalesceMask: .onName, forModes: nil)
        print("notifi after")

        let port = Port()
        RunLoop.current.add(port, forMode: .commonModes)
        RunLoop.current.run()
        print("runloop over")
    }
    
}

