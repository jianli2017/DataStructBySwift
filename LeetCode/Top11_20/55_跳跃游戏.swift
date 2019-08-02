//
//  55_跳跃游戏.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

判断你是否能够到达最后一个位置。

示例 1:

输入: [2,3,1,1,4]
输出: true
解释: 从位置 0 到 1 跳 1 步, 然后跳 3 步到达最后一个位置。
示例 2:

输入: [3,2,1,0,4]
输出: false
解释: 无论怎样，你总会到达索引为 3 的位置。但该位置的最大跳跃长度是 0 ， 所以你永远不可能到达最后一个位置。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/jump-game
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

class Solution_55_跳跃游戏 {
    
    //这个超时
    func canJump(_ nums: [Int]) -> Bool {
        let len = nums.count
        //回溯方法
        func canjumpFromPosition(_ position:Int) -> Bool {
            if position == len - 1  {
                return true
            }
            
            let furthestJump = min(position+nums[position], len - 1)
            var nextPositon = position + 1
            while nextPositon <= furthestJump {
                if canjumpFromPosition(nextPositon) {
                    return true
                }
                nextPositon += 1
            }
            return false
        }
        return canjumpFromPosition(0)
    }
    
    func canJump1(_ nums: [Int]) -> Bool {
        let len = nums.count
        enum Index {
            case Good;
            case Bad;
            case UnKonwn
        }
        var status = [Index](repeating: .UnKonwn, count: len)
        status[len - 1] = .Good
        for i in stride(from: len-2, through: 0, by: -1) {
            let furthestJump = min(i+nums[i], len - 1)
            var nextPositon = i + 1
            while nextPositon <= furthestJump {
                if status[nextPositon] == Index.Good {
                    status[i] = Index.Good
                    break
                }
                nextPositon += 1
            }
        }
        return status[0] == Index.Good
    }
    
    func canJump2(_ nums: [Int]) -> Bool {
        let len = nums.count
        var lastPos = len-1
        for i in stride(from: len-1, through: 0, by: -1) {
            if i+nums[i] >= lastPos {
                lastPos = i
            }
        }
        return lastPos == 0
    }
    
}

extension Solution_55_跳跃游戏 {
    static func test() {
        let instance = Solution_55_跳跃游戏()
        assert(instance.canJump([2,3,1,1,4]) )
        assert(instance.canJump([3,2,1,0,4]) == false)
        
        assert(instance.canJump1([2,3,1,1,4]) )
        assert(instance.canJump1([3,2,1,0,4]) == false)
        
        print("测试完成")
    }
}
