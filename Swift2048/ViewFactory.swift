//
//  ViewFactory.swift
//  Swift2048
//
//  Created by 姜雨生 on 16/3/26.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

import UIKit

enum ViewType {
    case label
    case button
    case textField
    case segment
}

class ViewFactory: NSObject {

    class func getDefaultFrame() -> CGRect{
        return CGRect(x: 0, y: 0, width: 100, height: 30)
    }
    
    class func createControl(type:ViewType, title:[String],action:Selector,sender:AnyObject) -> UIView{
        switch type {
        case .label:
            return ViewFactory.creatLabel(title[0])
        case .button:
            return ViewFactory.creatButton(title[0], action: action, sender: sender as! UIViewController)
        case .segment:
            return ViewFactory.createSegment(title, action: action, sender: sender as! UIViewController)
        case .textField:
            return ViewFactory.creatTextField(title[0], action: action, sender: sender as! UITextFieldDelegate)
        
        }
    }
    
    class func creatLabel(title:String)->UILabel{
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor.whiteColor()
        label.text = title
        label.frame = ViewFactory.getDefaultFrame()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }
    
    class func creatButton(title:String,action:Selector,sender:UIViewController) -> UIButton{
        let button = UIButton(frame: ViewFactory.getDefaultFrame())
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        return button
    }
    
    class func creatTextField(value:String,action:Selector,sender:UITextFieldDelegate) -> UITextField{
        let textField = UITextField(frame: ViewFactory.getDefaultFrame())
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.blackColor()
        textField.text = value
        textField.borderStyle = .RoundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        return textField
    }
    
    class func createSegment(items:[String],action:Selector,sender:UIViewController) -> UISegmentedControl
    {
            let segment = UISegmentedControl(items: items)
            segment.frame = ViewFactory.getDefaultFrame()
            segment.momentary = false
            segment.addTarget(sender, action: action, forControlEvents: .ValueChanged)
            return segment
    }
    
}
