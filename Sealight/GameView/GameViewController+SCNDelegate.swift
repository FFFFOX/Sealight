//
//  GameViewController+SCNDelegate.swift
//  Sealight
//
//  Created by Gavin on 2020/8/8.
//  Copyright © 2020 Name. All rights reserved.
//

import UIKit
import SceneKit

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            // 每 1 到 2 秒生成1条鱼
            if time > self.spawnTime {
                self.spawnFish()
                self.spawnTime = time + TimeInterval(Float.random(in: 1...2))
            }
            self.nodeStateManage()
        }
    }
}
