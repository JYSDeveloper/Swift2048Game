//
//  GameModel.swift
//  Swift2048
//
//  Created by 姜雨生 on 16/3/26.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

import UIKit

class GameModel: NSObject {

    var dimension:Int = 0
    var tiles:Array<Int>!
    var mtiles:Array<Int>!

    
    
    init(dimension:Int) {
        self.dimension = dimension
        self.tiles = Array<Int>(count: self.dimension * self.dimension,repeatedValue: 0)
        self.mtiles = Array<Int>(count: self.dimension * self.dimension,repeatedValue: 0)

    }
    func emptyPositions() -> [Int] {
        
        var emptyTiles = Array<Int>()
        for i in 0..<(dimension*dimension) {
            if tiles[i] == 0 {
                emptyTiles.append(i)
            }
        }
        return emptyTiles
    }
    
    func isFull()-> Bool {
        if emptyPositions().count == 0 {
            return true
        }
        return false
    }
    
    func setPosition(row:Int,col:Int,value:Int) ->Bool{
        assert(row >= 0 && row < dimension)
        assert(row >= 0 && row < dimension)
        let index = self.dimension * row + col
        let val = tiles[index]
        if  val > 0{
            print("no space")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func reflowUp(){
        copyToMtiles()
        var index:Int
        //for var i in 0...dimension-1{

        for var i = dimension-1;i>0 ; i-=1{
            for j in 0..<dimension
            {
                index = self.dimension * i+j
                if(mtiles[index-self.dimension] == 0
                    && (mtiles[index] > 0))
                {
                    mtiles[index-self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while(subindex+self.dimension<mtiles.count)
                    {
                        if(mtiles[subindex+self.dimension]>0)
                        {
                            mtiles[subindex] = mtiles[subindex+self.dimension]
                            mtiles[subindex+self.dimension] = 0
                        }
                        subindex += self.dimension
                    
                }

        }
            }
        }
    copyFromMtiles()
}
    
    func reflowDown(){
        copyToMtiles()
        var index:Int
        for i in 0..<dimension-1 {
            for j in 0..<dimension {
                index = self.dimension * i + j
                if (mtiles[index + self.dimension]==0) && (mtiles[index]>0) {
                    mtiles[index+self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    var subIndex:Int = index
                    while (subIndex - self.dimension)>=0 {
                        if mtiles[subIndex - self.dimension]>0 {
                            mtiles[subIndex] = mtiles[subIndex - self.dimension]
                            mtiles[subIndex - self.dimension] = 0
                        }
                        subIndex -= self.dimension
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowLeft(){
        copyToMtiles()
        var index:Int
        for i in 0..<dimension {
            for var j=dimension-1; j>0; j-- {
                index = self.dimension * i + j
                if (mtiles[index-1] == 0)
                    && (mtiles[index] > 0)
                {
                    mtiles[index-1] = mtiles[index]
                    mtiles[index] = 0
                    var subindex:Int = index
                    //对后面的内容进行检查
                    while((subindex+1) < i*dimension+dimension)
                    {
                        if (mtiles[subindex+1]>0)
                        {
                            mtiles[subindex] = mtiles[subindex+1]
                            mtiles[subindex+1] = 0
                        }
                        subindex += 1
                    }
                    
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowRight(){
        copyToMtiles()
        var index:Int
        for i in 0..<dimension {
            for j in 0..<dimension-1 {
                index = self.dimension * i + j
                if (mtiles[index+1] == 0)
                    && (mtiles[index] > 0)
                {
                    mtiles[index+1] = mtiles[index]
                    mtiles[index] = 0
                    var subindex:Int = index
                    //对后面的内容进行检查
                    while((subindex-1) > i*dimension-1)
                    {
                        if (mtiles[subindex-1]>0)
                        {
                            mtiles[subindex] = mtiles[subindex-1]
                            mtiles[subindex-1] = 0
                        }
                        subindex -= 1
                    }
                    
                }
            }
        }
        copyFromMtiles()
    }


    func  mergeUp()
    {
        copyToMtiles()
        var index:Int
        for var i=dimension-1; i>0; i -= 1
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if((mtiles[index] > 0) && (mtiles[index-self.dimension] == mtiles[index]))
                {
                    mtiles[index-self.dimension] = mtiles[index] * 2
                  //  changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeDown()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension-1 {
            for j in 0..<dimension {
                index = self.dimension * i + j
                if (mtiles[index] > 0 && mtiles[index+self.dimension] == mtiles[index])
                {
                    mtiles[index+self.dimension] = mtiles[index] * 2
                    //changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeLeft()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension {
           
            for j in 1..<dimension{
                index = self.dimension * i + j
                if (mtiles[index] > 0 && mtiles[index-1] == mtiles[index])
                {
                    mtiles[index-1] = mtiles[index] * 2
                   // changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeRight()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension {
            for j in 0..<dimension-1 {
                index = self.dimension * i + j
                if (mtiles[index] > 0 && mtiles[index+1] == mtiles[index])
                {
                    mtiles[index+1] = mtiles[index] * 2
                  //  changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }

    
    func copyToMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            mtiles[i] = tiles[i]
        }
    }
    func copyFromMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            tiles[i] = mtiles[i]
        }
    }
    
    func isSuccess() -> Bool
    {
        for i in 0..<(dimension*dimension)
        {
            if(tiles[i] >= 2014)
            {
                print("true")
                return true
            }
        }
        return false
    }

}
