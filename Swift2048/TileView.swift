//
//  TileView.swift
//  Swift2048
//
//  Created by 姜雨生 on 16/3/26.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

import UIKit

class TileView: UIView {

    let colorMap = [
        2:UIColor.redColor(),
        4:UIColor.orangeColor(),
        8:UIColor.yellowColor(),
        16:UIColor.greenColor(),
        32:UIColor.brownColor(),
        64:UIColor.blueColor(),
        128:UIColor.purpleColor(),
        256:UIColor.cyanColor(),
        512:UIColor.lightGrayColor(),
        1024:UIColor.magentaColor(),
        2048:UIColor.blackColor()
    ]
    var numberLabel:UILabel!
    
    var value:Int = 0{
        didSet{
            backgroundColor = colorMap[value]
            numberLabel.text = "\(value)"
        }
    }
    
    init(pos:CGPoint,width:CGFloat,value:Int){
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = .Center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name: "微软雅黑", size: 20)
        numberLabel.text = "\(value)"
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: width, height: width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value]
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
