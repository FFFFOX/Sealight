//
//  GuideView.swift
//  Sealight
//
//  Created by Gavin on 2020/8/7.
//  Copyright © 2020 Name. All rights reserved.
//
// 引导视图

import UIKit

class GuideView: UIView {
    
    // Texts Stack View
    @IBOutlet weak var textsStackView: UIStackView!
    // 背景图片
    @IBOutlet weak var backgroundImg: UIImageView!
    // 用来加载引导页xib文件的内容视图
    var contentView: GuideView!
    
    // 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 加载
        contentView = Bundle.main.loadNibNamed("GuideView", owner: self, options: nil)?.first as? GuideView
        contentView.frame = bounds
        addSubview(contentView)
        
        // 动画
        clearSubViews()
        showBackground()
        showTexts()
        disappear()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // 隐藏所有元素
    func clearSubViews() {
        contentView.textsStackView.alpha = 0
        contentView.backgroundImg.alpha = 0
    }
    // 1-3秒：背景出现
    func showBackground() {
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut, animations: {
            self.contentView.backgroundImg.alpha = 1
        })
    }
    // 4-5秒：文字渐显
    func showTexts() {
        UIView.animate(withDuration: 2, delay: 3, options: .curveEaseInOut, animations: {
            self.contentView.textsStackView.alpha = 1
        })
    }
    
    // 6-7秒：消失（过渡到主页）
    func disappear() {

        UIView.animate(withDuration: 2, delay: 7, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }, completion: { (true) in
            self.disappear()
        })
    }
    
    
    
}


