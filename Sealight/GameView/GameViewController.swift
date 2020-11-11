//
//  GameViewController.swift
//  Sealight
//
//  Created by Gavin on 2020/8/8.
//  Copyright © 2020 Name. All rights reserved.
//

import UIKit
import SceneKit
import ModelIO
import SceneKit.ModelIO
import CoreMotion
import AVFoundation

// 游戏主界面
class GameViewController: UIViewController {
    var motionManager = CMMotionManager()
    // 游戏场景视图
    @IBOutlet weak var scnView: SCNView!
    // 游戏场景
    var scene: SCNScene!
    // 相机节点
    var cameraNode: SCNNode!
    
    // 可视游戏模式
    var lightGameMode = true
    
    // 鱼生成的时间计数
    var spawnTime: TimeInterval = 3
    // 所有鱼对象数组
    var fishes: [SCNNode] = []
    
    // 音乐播放器
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var playLeft: Bool!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecognizers()
        phoneMotion()
        
        // 游戏
        setupView()
        setupScene()
        setupCamera()
    }
    
    // MARK: - 游戏相关
    // MARK: 加载音乐
    func setupMusic(name: String) {
        let musicUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            audioPlayer.volume = 1
        } catch {
            print("播放错误")
        }
        
       }
    
    
    // MARK: 视图和场景
    func setupView() {
        // 遵守渲染协议
        scnView.delegate = self
        // 显示debug数据
        scnView.showsStatistics = true
        // 允许控制相机
        scnView.allowsCameraControl = false
        // 自动调整灯光
        scnView.autoenablesDefaultLighting = true
    }
    func setupScene() {
        scene = SCNScene()
        scnView.scene = scene
        // 设置游戏背景
        scene.background.contents = UIImage(named: "lightgamebackground")
    }
    
    // MARK: 相机
    // 生成相机
    func setupCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        cameraNode.camera?.zNear = 0
        scene.rootNode.addChildNode(cameraNode)
    }
    // 相机移动
    func moveCamera(motionY: Double) {
        if motionY < -0.05 {
            let distance = motionY / 8
            cameraNode.position.x -= Float(distance)
        }
        if motionY > 0.05 {
            let distance = motionY / 8
            cameraNode.position.x -= Float(distance)
        }
        
    }
    
    
    // MARK: 生成来鱼
    func spawnFish() {
        // 加载模型并添加
        guard let url = Bundle.main.url(forResource: "fish1", withExtension: "obj", subdirectory: "models.scnassets")
            else { fatalError("Failed to find model file.") }
        
        let asset = MDLAsset(url:url)
        guard let object = asset.object(at: 0) as? MDLMesh
            else { fatalError("Failed to get mesh from asset.") }
        let node = SCNNode(mdlObject: object)
        // 出现方向，0左边1右边
        let leftOrRight = Int.random(in: 0...1)
        // 以相机位置为中心
        let cameraX = cameraNode.position.x
        // 出现位置随机
        var positionX: Float
        var positionY: Float
        if leftOrRight == 0 {
            positionX = cameraX - 1.5 - Float.random(in: 0...5)
            positionY = Float.random(in: 0...3)
        } else {
            positionX = cameraX + 1.5 + Float.random(in: 0...5)
            positionY = Float.random(in: 0...3)
        }
        
        
        node.position =  SCNVector3(x: positionX, y: positionY, z: -6)
        scene.rootNode.addChildNode(node)
        // 将节点加入数组方便管理
        fishes.append(node)

        // 运动设置，往相机方向运动
        let action = SCNAction.move(to: cameraNode.position, duration: Double.random(in: 3...8))
        node.runAction(action)
        
        
        // 指向相机
        let f3 = simd_float3(cameraNode.position)
        node.simdLook(at: f3)
    }
    
    // MARK: 节点状态管理
    func nodeStateManage() {
        // 声音处理
        if !fishes.isEmpty {
            // 最早的鱼和相机的距离
            let distance = nodeDistance(p1: fishes.first!.position, p2: cameraNode.position)
            
            if fishes.first!.position.x < cameraNode.position.x {
                if playLeft == nil  || playLeft == false {
                    playLeft = true
                    setupMusic(name: "BubbleLeft")
                }
                
                if distance > 6 {
                    audioPlayer.volume = 0
                } else {
                    audioPlayer.volume = (6 - distance) / 6
                }
                
            } else {
                if playLeft == nil  || playLeft == true {
                    playLeft = false
                    setupMusic(name: "BubbleRight")
                }
                
                if distance > 6 {
                    audioPlayer.volume = 0
                } else {
                    audioPlayer.volume = (6 - distance) / 6
                }
                
            }
            
        }
        
        // 节点越界管理
        for node in scene.rootNode.childNodes {
            if node.position.z > -0.01 {
                // 从数组中移除节点
                if fishes.firstIndex(of: node) != nil {
                    fishes.remove(at: fishes.firstIndex(of: node)!)
                }
                // 从场景中移除节点
                node.removeFromParentNode()
            }
        }
    }
    
    // 计算两个节点的距离
    func nodeDistance(p1: SCNVector3, p2: SCNVector3) -> Float {
        let distanceX = (p1.x - p2.x) * (p1.x - p2.x)
        let distanceY = (p1.y - p2.y) * (p1.y - p2.y)
        let distanceZ = (p1.z - p2.z) * (p1.z - p2.z)
        let distance = sqrtf(distanceX + distanceY + distanceZ)
        return distance
    }
    
    // MARK: - 捕获手机运动数据
    func phoneMotion() {
        motionManager.accelerometerUpdateInterval = 1 / 60
        guard motionManager.isAccelerometerAvailable else {
            print("当前设备支持加速计")
            return
        }
        let queue = OperationQueue.current
        motionManager.startAccelerometerUpdates(to: queue!) { (accelerometereData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if self.motionManager.isAccelerometerActive {
                //                var text = "---当前加速计数据---\n"
                //                text += "x: \(accelerometereData!.acceleration.x)\n"
                //                text += "y: \(accelerometereData!.acceleration.y)\n"
                //                text += "z: \(accelerometereData!.acceleration.z)\n"
                //                print(text)
                // 移动相机
                self.moveCamera(motionY: accelerometereData!.acceleration.y)
            }
            
            
        }
    }
    
    
    // MARK: - 手势
    // 单指长按屏幕三秒回到主页
    func setupRecognizers() {
        let currectSquareGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GameViewController.back(recognizer:)))
        currectSquareGestureRecognizer.minimumPressDuration = 2
        currectSquareGestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(currectSquareGestureRecognizer)
    }
    // 返回逻辑
    @objc func back(recognizer: UILongPressGestureRecognizer) {
        // 停止加速计计算
        motionManager.stopAccelerometerUpdates()
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
