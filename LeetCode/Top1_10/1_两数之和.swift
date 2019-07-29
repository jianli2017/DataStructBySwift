//
//  1_两数之和.swift
//  DataStruct
//
//  Created by lijian on 2019/7/25.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_两数之和_ {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var ret = [Int]()
        var map = [Int: Int]()
        for (index, value) in nums.enumerated() {
            map[value] = index
        }
        for(index, value) in nums.enumerated() {
            let nextValue = target - value
            if let nextIndex = map[nextValue] {
                if nextIndex != index {
                    ret.append(index)
                    ret.append(nextIndex)
                    break
                }
            }
        }
        return ret
    }
    
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        // num = [2, 7, 11, 15] target = 9
        var dict = [Int: Int]()
        for (i, v) in nums.enumerated() {
            // i = 0, v = 2
            if let lastIndex = dict[target - v] {
                return [lastIndex, i]
            }else {
                dict[v] = i
            }
        }
        fatalError("NO Output")
    }
    
    
}
/*
// num = [2, 7, 11, 15] target = 9
var dict = [Int: Int]()
for (i, v) in nums.enumerated() {
    // i = 0, v = 2
    if let lastIndex = dict[target - v] {
        return [lastIndex, i]
    }else {
        dict[v] = i
    }
}
fatalError("NO Output")
*/
