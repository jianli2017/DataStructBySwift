//
//  39_组合总和.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。

candidates 中的数字可以无限制重复被选取。

说明：

所有数字（包括 target）都是正整数。
解集不能包含重复的组合。
示例 1:

输入: candidates = [2,3,6,7], target = 7,
所求解集为:
[
[7],
[2,2,3]
]
示例 2:

输入: candidates = [2,3,5], target = 8,
所求解集为:
[
  [2,2,2,2],
  [2,3,3],
  [3,5]
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/combination-sum
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution_39_组合总和 {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var res = [[Int]]()
        let len = candidates.count
        var __candidates = candidates.sorted { (a, b) -> Bool in
            a < b
        }
        
        //递归函数
        func combinationSumhelp(_ stack: inout [Int],_ start: Int, _ target: Int ) ->Bool {
            if target < 0 {
                return false
            } else if (target == 0) {
                res.append(stack)
                return false
            } else {
                for i in start..<len {
                    stack.append(__candidates[i])
                    let flag = combinationSumhelp(&stack, i, target - __candidates[i])
                    stack.removeLast()
                    if !flag {
                        break
                    }
                    
                }
            }
            return true
        }
        
        
        //代码的主题部分
        if len == 0 {
            return res
        }
        
        //排序
        var stack = [Int]()
        combinationSumhelp(&stack, 0, target)
        return res
    }
}

extension Solution_39_组合总和 {
    static func test() {
        let instance  = Solution_39_组合总和()
        print(instance.combinationSum([2,3,6,7], 7))
        
        print(instance.combinationSum([2,3,5], 8))
        
        print("测试完成")
    }
}
