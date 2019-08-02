//
//  46_全排列.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

/*
给定一个没有重复数字的序列，返回其所有可能的全排列。

示例:

输入: [1,2,3]
输出:
[
[1,2,3],
[1,3,2],
[2,1,3],
[2,3,1],
[3,1,2],
[3,2,1]
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/permutations
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

import Foundation
class Solution_46_全排列 {
    func permute(_ nums: [Int]) -> [[Int]] {
        var len = nums.count
        var res = [[Int]]()
        func recursive(_ stack: inout [Int], _ position: Int) {
            if position == len {
                res.append(stack)
                return
            }
            
            for i in position..<len {
                stack.swapAt(position,i )
                recursive(&stack, position+1)
                stack.swapAt(position,i )
            }
        }
        
        //主代码
        if len == 0 {
            return res
        }
        var stack = [Int]()
        for i in nums {
            stack.append(i)
        }
        
        recursive(&stack, 0)
        return res
    }
}

extension Solution_46_全排列 {
    static func test() {
        let instance = Solution_46_全排列()
        print(instance.permute([1,2,3]))
        print("测试完成")
    }
}
