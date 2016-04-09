//
//  ViewController.swift
//  Swift2048
//
//  Created by 姜雨生 on 16/3/26.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //游戏方格维度
    var dimension:Int = 4
    //游戏过关最大值
    var maxNumber:Int = 2048
    //格子宽度
    var width:CGFloat = 80
    //格子间距
    var padding:CGFloat = 6
    //背景图数据
    var backgrounds:Array<UIView>! = Array()
    //模型数据
    var model :GameModel = GameModel(dimension: 4)
    //界面Label数据
    var tiles:Dictionary<NSIndexPath,TileView>! = Dictionary()
    //Label实际数据
    var tileVals: Dictionary<NSIndexPath, Int>! = Dictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupGameMap()
        setupScoreLabels()
        setupSwipGuestures()
        genNumber()
        genNumber()
    }
    //添加游戏界面
    func setupGameMap(){
        var x :CGFloat = 30
        var y :CGFloat = 150
        for _ in 0..<dimension {
            y = 150
            for _ in 0..<dimension {
                let background = UIView(frame: CGRect(x: x, y: y, width: width, height: width))
                background.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(background)
                backgrounds.append(background)
                y += padding + width
            }
            x += padding + width
        }
    }
    //添加label
    func setupScoreLabels() {
        let score = ScoreView(scoreType: ScoreType.Common)
        score.frame.origin = CGPoint(x: 30, y: 80)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        let bestScore = ScoreView(scoreType: ScoreType.Best)
        bestScore.frame.origin = CGPoint(x: 250, y: 80)
        bestScore.changeScore(value: 0)
        self.view.addSubview(bestScore)
    }
    //生成随机数
    func genNumber(){
        
        let randV = Int(arc4random_uniform(10))
        var seed:Int = 2
        if randV == 1 {
            seed = 4
        }
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        if model.isFull() {
            return
        }
        if !model.setPosition(row, col: col, value: seed) {
            genNumber()
            return
        }
        
        insertTile((row,col), value: seed)
    }
    //添加滑块
    func insertTile(pos:(Int,Int),value:Int){
        print("add")
        let (row,col) = pos;
        let x = 30 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        let tile = TileView(pos: CGPointMake(x, y), width: width, value: value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        let index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        
        
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        UIView.animateWithDuration(0.3, delay: 0.1, options: .TransitionNone, animations: {
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
        })
        { (finished:Bool) in
            UIView.animateWithDuration(0.1, animations: {
        tile.layer.setAffineTransform(CGAffineTransformIdentity)
            })
        }
    }
    //添加手势
    func setupSwipGuestures() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipUp))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipDown))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = .Down
        self.view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipLeft))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = .Left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipRight))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = .Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func initUI()
    {
        
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        
        
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                index = i*self.dimension + j
                key = NSIndexPath(forRow:i, inSection:j)
                //原来界面没有值，模型数据中有值
                if((model.tiles[index]>0) && tileVals.indexForKey(key)==nil)
                {
                    insertTile((i,j),value:model.tiles[index])
                }
                //原来界面中有值，现在模型中没有值 了
                if((model.tiles[index] == 0) && (tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                //原来值，但是现在还有值
                if((model.tiles[index] > 0) && (tileVals.indexForKey(key) != nil))
                {
                    tileVal = tileVals[key]!
                    if(tileVal != model.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.removeFromSuperview()
                        tiles.removeValueForKey(key)
                        tileVals.removeValueForKey(key)
                        insertTile((i,j),value:model.tiles[index])
                    }
                }
            }
        }
        if(model.isSuccess())
        {

            let alertView = UIAlertView()
            alertView.title = "恭喜您通关"
            alertView.message = "嘿，真棒，您通关了!"
            alertView.addButtonWithTitle("确定")
            alertView.show()
            return;
        }
    }

    func swipUp(){
        print("up")
        model.reflowUp()
        model.mergeUp()
        model.reflowUp()
        initUI()
        if model.isSuccess(){
        genNumber()
        }
    }
    func swipDown(){
        print("swipeDown")
        model.reflowDown()
        model.mergeDown()
        model.reflowDown()
        initUI()
        if(!model.isSuccess())
        {
            genNumber()
        }

    }
    func swipLeft(){
        print("left")
        model.reflowLeft()
        model.mergeLeft()
        model.reflowLeft()
        initUI()
        if(!model.isSuccess())
        {
            genNumber()
        }

    }
    func swipRight(){
        print("right")
        model.reflowRight()
        model.mergeRight()
        model.reflowRight()
        initUI()
        if(!model.isSuccess())
        {
            genNumber()
        }

    }
    func removeKeyTile(key:NSIndexPath)
    {
        let tile = tiles[key]!
       // let tileVal = tileVals[key]
        
        tile.removeFromSuperview()
        tiles.removeValueForKey(key)
        tileVals.removeValueForKey(key)
    }
    func printTiles(tiles:Array<Int>)
    {
        let count = tiles.count
        for i in 0 ..< count
        {
            if (i+1) % Int(dimension) == 0
            {
                print(tiles[i])
            }
            else
            {
                print("\(tiles[i])\t", terminator: "")
            }
        }
        
        print("")
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

