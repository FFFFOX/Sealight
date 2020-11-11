//
//  ViewController.swift
//  Sealight
//
//  Created by Gavin on 2020/8/7.
//  Copyright © 2020 Name. All rights reserved.
//

import UIKit



// 主页
class MainViewController: UIViewController {
    
    // 引导视图
    var guideView: GuideView!
    // 背景图
    @IBOutlet weak var backgroundImg: UIImageView!
    // 按钮
    @IBOutlet weak var knowledgeButton: MainViewButton!
    @IBOutlet weak var gameButton: MainViewButton!
    
    // 知识模式状态
    var knowledge = false
    
    // 知识模式点击计数
    var knowledgeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGuideView()
    }
    
    
    //     设置引导视图
    func setupGuideView() {
        // 初始化引导视图
        guideView = GuideView(frame: view.bounds)
        // 添加到父视图上
        view.addSubview(guideView)
    }
    
    // MARK: 按钮点击
    @IBAction func clickKnowledgeButton(_ sender: MainViewButton) {
        buttonDisappear()
        bgImgDarker()
    }
    
    @IBAction func clickGameButton(_ sender: MainViewButton) {
        performSegue(withIdentifier: "gameView", sender: nil)
    }
    
    
    // MARK: 进入知识模式动画
    // 按钮消失
    func buttonDisappear() {
        knowledgeButton.isEnabled = false
        gameButton.isEnabled = false
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.knowledgeButton.alpha = 0
            self.gameButton.alpha = 0
        }, completion: { (true) in
            self.knowledge = true
        })
    }
    // 照片变暗
    func bgImgDarker() {
        UIView.animate(withDuration: 2, delay: 2, options: .curveEaseInOut, animations: {
            self.backgroundImg.alpha = 0.3
            self.showKnowledge()
        }, completion: nil)
        
    }
    
    func textAppear(){
        
    }
    
    // MARK: 退出知识模式动画
    func bgImgLighter() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundImg.alpha = 1
        }, completion: nil)
    }
    func buttonShower() {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.knowledgeButton.alpha = 1
            self.gameButton.alpha = 1
            
        }, completion: { (true) in
            self.knowledgeButton.isEnabled = true
            self.gameButton.isEnabled = true
        })
    }
    
    let text:[String] = ["海豚：海豚的皮肤光滑无毛，身体矫健而灵活，善于跳跃和潜泳，是在水中行动最迅速的哺乳动物。海豚头部具有瓣膜和气囊系统，通过这类系统将声波放射出去。当超声信号遇到目标时，形成低频的反射信号，再由耳或头部的其他器官接收，构成完善的声呐系统。活动时主要依靠回声定位功能，在水中和空气中均有极好的听力。很多人都知道海豚有着极其敏锐的听觉，但你可知道，海豚是没有嗅觉的，因为它们缺乏嗅觉神经。它们的大脑沟回复杂，记忆力良好，能在人类的训练下学会许多动作，是智商最高的动物家族之一，有着温和友善、活泼好动的性格，它们对人类的许多动作都有积极的反应，甚至能用肢体语言互相交流，受到世界各地人民的普遍喜爱。而事实上，在水族馆从事表演的海豚，许多都有严重的心理问题；有的海豚甚至会主动终结自己的生命。","海象海象身体庞大，皮厚而多皱，眼睛小，是群栖性的动物。在冰冷的海水中和陆地的冰块上过着两栖的生活，每群可从几十只、数百只到成千上万只。为了恢复在海洋中长期游动后的疲劳，在陆地上大多数时间是睡觉和休息，有时用獠牙与较短的后肢来摇摇晃晃地行走，显得十分笨拙，滑稽可笑。但在海水中靠着流线型的身体、发达的肌肉以及强有力的鳍状肢，则行动自如，非常机敏，用后肢推进，前肢转弯，时速达24公里，可潜至70米以下的深度，能够完成取食、求偶、交配等各种活动。视觉较差，但嗅觉与听觉却颇为敏锐。群体在睡觉时总会留下一只放哨，发现有危险来临时，便立即发出公牛似的吼声，将同伴唤醒，或用獠牙碰醒身旁的其他个体，并依次传递临危警报。如果群体较大，放哨的还常常在水里游动，不断探出头来监视周围的情况。它的天敌主要是北极熊，常常捕食幼仔，但较少进攻身躯庞大的成体。另一个主要天敌是号称“海中霸王”的虎鲸，如果相遇，海象只能急速地逃到陆地上，使不能登陆的虎鲸毫无办法。","海洋（sea），地理名词，是地球上最广阔的水体的总称。地球表面被各大陆地分隔为彼此相通的广大水域称为海洋，海洋的中心部分称作洋，边缘部分称作海，彼此沟通组成统一的水体。地球上海洋总面积约为3.6亿平方公里，约占地球表面积的71%，平均水深约3795米。海洋中含有十三亿五千多万立方千米的水，约占地球上总水量的97%，而可用于人类饮用只占2%。地球四个主要的大洋为太平洋、大西洋、印度洋、北冰洋，大部分以陆地和海底地形线为界。目前为止，人类已探索的海底只有5%，还有95%大海的海底是未知的。","海狮海狮是非常社会化的动物，它们有各种各样的通信方式。通常集群活动，有时在陆岸可组成上千头的大群，但在海上常发现有1头或十数头的小群体。白天在海中捕食，游泳和潜水主要依靠较长的前肢，偶而也会爬到岸上晒晒太阳，夜里则在岸上睡觉。除了繁殖期外一般没有固定的栖息场所，雄兽每个月要花上2-3周的时间去远处巡游觅食，而雌兽和幼仔在陆地上逗留的时间相对较多。海狮被认为是很胆小和温顺的动物，但也出现一些对人类有攻击性的报道。在繁殖期间有较强的领地意识，雄性则更加活跃，尤其当涉及到与雌性的交配权时。海狮以鱼类、乌贼、海蛰和蚌为食，也爱吃磷虾，有时在饥饿的时候甚至会吃企鹅。多为整吞，不加咀嚼。海狮的食量很大，所以它们大部分时间呆在海里捕食食物，填饱自己的大胃口，以得到满足游泳运动的能量。为了帮助消化，还要吞食一些小石子。科学家利用它们喜欢磷虾的特性，让海狮做起了“特约科学员”。科学家在其身上安装电子记录仪，检测海狮的游泳速度和活动范围，以此推断磷虾群的远近、大小和动态变化。","扇贝,甲壳类是发声最多的类种，如蟹类和虾类等。这类动物通常用钳和触角之类，撞击和摩擦发出劈啪声、喀哒声或锉磨声。有些亚热带的虾有一个特别大的螯，用以发声。这种噪声，大部分是无脊椎动物在进食和运动中发出的，噪声频谱介于20赫到20千赫之间。在这些动物群集的温暖海区，噪声很大，在10~20千赫范围内，可能比 2级海况下的海洋噪声大45分贝之多。软体动物中,贝类在它们的壳开合时发出碰撞声;乌贼和章鱼在用坚硬的嘴进食时发出锉磨声，在喷水向前推进时发出砰砰声;藤壶和海胆在移动时也会发出喀哒声。无脊椎动物的某些发声可能和繁殖有关，或作为警告的信号。"]
    let labeltx:UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 700, height: 200))
    
    //    view.addSubview(labeltx)
    
    
    func showKnowledge() {
        labeltx.alpha = 0
        view.addSubview(labeltx)
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseInOut, animations: {
            self.labeltx.text = self.text[self.knowledgeCount]
            
            self.labeltx.textColor = .white
            self.labeltx.numberOfLines = 15
            self.labeltx.alpha = 1
        }, completion: nil)
        
    }
    
    func showNextKnowledge() {
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseInOut, animations: {
            
            self.knowledgeCount += 1
            if (self.knowledgeCount == self.text.count){
                self.knowledgeCount = 0
                self.labeltx.text = self.text[self.knowledgeCount]
            }else{
                self.labeltx.text = self.text[self.knowledgeCount]
            }
            self.labeltx.text = self.text[self.knowledgeCount]
            self.labeltx.textColor = .white
            self.labeltx.numberOfLines = 15
            self.labeltx.alpha = 1
        }, completion: nil)
    }
    // 点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 进入知识模式后点击屏幕可以进入下一个知识点
        if knowledge {
            print("下一个知识点")
            labeltx.alpha = 1
//            UIView.animate(withDuration: 6, delay: 0, options: .curveEaseInOut, animations: {
//                self.labeltx.alpha = 0
//            }, completion: nil)
            UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
                self.labeltx.alpha = 0
            }, completion: { (true) in
                UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.knowledgeCount += 1
                    if (self.knowledgeCount == self.text.count){
                        self.knowledgeCount = 0
                        self.labeltx.text = self.text[self.knowledgeCount]
                    }else{
                        self.labeltx.text = self.text[self.knowledgeCount]
                    }
                    self.labeltx.text = self.text[self.knowledgeCount]
                    self.labeltx.textColor = .white
                    self.labeltx.numberOfLines = 15
                    self.labeltx.alpha = 1
                }, completion: nil)
            })
        }
        
    }
    
    // 摇晃事件
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // 进入知识模式后摇晃手机可以反悔
        if knowledge {
            knowledge = false
            bgImgLighter()
            buttonShower()
            labeltx.text = ""
            knowledgeCount = 0
        }
    }
    
}

