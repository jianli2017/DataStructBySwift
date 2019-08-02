//
//  15_三数之和.swift
//  DataStruct
//
//  Created by lijian on 2019/7/29.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class solution_15_三数之和 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        let sortedNums = nums.sorted { (i, j) -> Bool in
            return i<j
        }
        
        guard sortedNums.count != 0, sortedNums[0] <= 0, sortedNums[sortedNums.count - 1] >= 0 else {
            return res
        }
        
        for k in 0..<sortedNums.count {
            if sortedNums[k] > 0 { //如果这个数大于0 ，没有可能的结果
                break
            }
            
            if k>0 && sortedNums[k] == sortedNums[k-1] { //重复元素
                continue
            }
            
            let target = 0 - sortedNums[k]
            var i = k + 1
            var j = sortedNums.count - 1
            while i < j {
                if (sortedNums[i] + sortedNums[j]) == target {
                    res.append([sortedNums[k], sortedNums[i], sortedNums[j]])
                    while i < j && sortedNums[i] == sortedNums[i + 1] {  //去掉重复的
                        i += 1
                    }
                    while (i < j && sortedNums[j] == sortedNums[j - 1]) { //去掉重复的
                        j -= 1
                    }
                    i += 1
                    j -= 1
                } else if sortedNums[i] + sortedNums[j] < target {
                    i += 1
                } else {
                    j -= 1
                }
            }
        }
        return res
    }
}

extension solution_15_三数之和 {
    static func test() {
        let instance = solution_15_三数之和()
        print(instance.threeSum([-1, 0, 1, 2, -1, -4]))
        
        print(instance.threeSum([0,0,0]))
    }
}
