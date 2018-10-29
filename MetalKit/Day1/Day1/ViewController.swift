//
//  ViewController.swift
//  Day1
//
//  Created by 黄伯驹 on 2017/10/24.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mtkView = MyView(frame: view.frame)

        view.addSubview(mtkView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class MyView: MTKView {
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, device: MTLCreateSystemDefaultDevice())
    }

    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        self.device = device
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let drawable = currentDrawable, let rpd = currentRenderPassDescriptor {
//            rpd.colorAttachments[0].texture = drawable.texture
            rpd.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
            rpd.colorAttachments[0].loadAction = .clear
            let commandBuffer = device?.makeCommandQueue()?.makeCommandBuffer()
            let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd)
            commandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }}

