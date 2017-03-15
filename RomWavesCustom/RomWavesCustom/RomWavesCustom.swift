//
//  RomWavesCustom.swift
//  RomWavesCustom
//
//  Created by 戴明亮 on 17/3/8.
//  Copyright © 2017年 戴明亮. All rights reserved.
//
import UIKit

class RomWavesCustom: UIView {

    
    // ************************************
    lazy var firstWavesLayer: CAShapeLayer = CAShapeLayer.init()
   fileprivate lazy  var wavesDisplayLink: CADisplayLink = CADisplayLink.init(target: self, selector: #selector(startwaves))
    // 懒加载的复杂的写法
    var secondWavesLayer: CAShapeLayer  = { () -> (CAShapeLayer) in
        let layer = CAShapeLayer.init()
        return layer
    }()
    
   fileprivate var wavesA_First: CGFloat = 0 // 波浪振幅
   fileprivate var wavesW_First: CGFloat = 0 // 波浪周期
   fileprivate var offsetX_First: CGFloat = 0 // 偏移
   fileprivate var wavesSpeed_Frist: CGFloat = 0 // 波浪速度
   fileprivate var wavesWidth_First: CGFloat = 0 // 波浪宽度
   fileprivate var wavesCurrentY_Frist: CGFloat = 0 // 当前波浪的高度（起始高度）
    
    
   fileprivate var wavesA_Second: Double = 0
   fileprivate var wavesW_Seocnd: Double = 0
   fileprivate var offsetX_Second: Double = 0
   fileprivate var wavesSpeed_Second: Double = 0
    
    var currentYOffset: ((_ offset: CGFloat ) -> ())?
    // ***********************************
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    @objc private func startwaves() {
        
        offsetX_First += wavesSpeed_Frist
        offsetX_Second += wavesSpeed_Second
        setCurrentFirstWavesLayerPath()
        setCurrentSecondWavesLayerPath()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



// MARK: - lazy
 fileprivate extension RomWavesCustom {

    // 布局子控件
      func setupSubViews() {
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
        wavesWidth_First = CGFloat(self.frame.size.width)
        wavesCurrentY_Frist = CGFloat(self.frame.size.height * 0.5)
        
        wavesSpeed_Frist = 0.02;
        wavesA_First = 12;
        wavesW_First = 0.5/30.0
        
        wavesSpeed_Second = 0.03;
        wavesA_Second = 13
        wavesW_Seocnd = 0.5/30.0
        
        
        
        firstWavesLayer.fillColor = UIColor.white.cgColor
        secondWavesLayer.fillColor = UIColor.white.withAlphaComponent(0.5).cgColor
        self.layer.addSublayer(firstWavesLayer)
        self.layer.addSublayer(secondWavesLayer)
        // 将定时器添加到当前运行循环中
        wavesDisplayLink.add(to: RunLoop.current, forMode: .commonModes)

    }
   
 
    
}


// MARK: - 绘制路劲
fileprivate extension RomWavesCustom {
    
    /// 绘制第一个波浪
    func setCurrentFirstWavesLayerPath(){
        
        let path = UIBezierPath.init()
        
        path.move(to: CGPoint.init(x: 0, y: wavesCurrentY_Frist))
        for i in 0...NSInteger(wavesWidth_First) {
            let y = wavesA_First * sin(wavesW_First * CGFloat(i) + offsetX_First) + wavesCurrentY_Frist
            path.addLine(to: CGPoint.init(x: CGFloat(i), y: y))
            
            guard let currentYOffsetBlock = currentYOffset else {
                return
            }
            currentYOffsetBlock(CGFloat(y))
            
            
            
        }
        path.addLine(to: CGPoint.init(x: wavesWidth_First, y: self.frame.size.height))
        
        path.addLine(to: CGPoint.init(x: 0, y: self.frame.size.height))
        
        path.close()
        
        firstWavesLayer.path = path.cgPath
        
        
    }
    
    
    /// 绘制第二个波浪
    func setCurrentSecondWavesLayerPath(){
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: 0, y: wavesCurrentY_Frist))
        
        
        for i in 0...Int(wavesWidth_First) {
            
            let y = wavesA_Second * cos( wavesW_Seocnd * Double(i) +  offsetX_Second * M_PI/2.0) + Double(wavesCurrentY_Frist)
            
            path.addLine(to: CGPoint.init(x: Double(i), y: y))
            
            
        }
        
        path.addLine(to: CGPoint.init(x: Double(wavesWidth_First), y: Double(self.frame.size.height)))
        path.addLine(to: CGPoint.init(x: Double(0), y: Double(self.frame.size.height)))
        path.close()
        
        secondWavesLayer.path = path.cgPath
        
        
    }
}

