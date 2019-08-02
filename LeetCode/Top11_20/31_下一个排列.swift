//
//  31_下一个排列.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_31_下一个排列 {
    func nextPermutation(_ nums: inout [Int]) {
        var i = nums.count - 2
        while i>=0 && nums[i+1] <= nums[i] {  //找第一个索引
            i -= 1
        }
        
        if i >= 0 {
            var j = nums.count - 1
            while j>=0 && nums[j] <= nums[i] {
                j -= 1
            }
            nums.swapAt(i, j)
        }
        reverse(nums: &nums, i + 1)
    }
    
    func reverse(nums: inout [Int], _ start: Int)  {
        var i = start
        var j = nums.count - 1
        while i < j {
            nums.swapAt(i, j)
            i += 1
            j -= 1
        }
    }
}

extension Solution_31_下一个排列 {
    static func test() {
        let instance = Solution_31_下一个排列()
        var a = [1,2,3]
//        instance.nextPermutation(&a)
        print(a)
        
        var b = [3,2,1]
        instance.nextPermutation(&b)
        print(b)
    }
}
