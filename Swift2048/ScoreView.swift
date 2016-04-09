//
//  ScoreView.swift
//  Swift2048
//
//  Created by 姜雨生 on 16/3/26.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

import UIKit

enum ScoreType {
    case Common //普通分数面板
    case Best   //最高分数面板
}
protocol ScoreViewProtocol {
    func changeScore(value s :Int)
}

class ScoreView: UIView,ScoreViewProtocol {

    var label :UILabel!
    let defaultFrame = CGRect(x: 0, y: 0, width: 100, height: 30)
    var scoreType:String!
    var score:Int = 0{
        didSet{
            label.text = "\(scoreType):\(score)"
        }
    }
    
    init(scoreType:ScoreType){
        label = UILabel(frame: defaultFrame)
        label.textAlignment = .Center
        super.init(frame: defaultFrame)
        self.scoreType = (scoreType == ScoreType.Common ? "分数":"最高分")
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //实现协议方法
    func changeScore(value s: Int) {
        score = s
    }
    

}
