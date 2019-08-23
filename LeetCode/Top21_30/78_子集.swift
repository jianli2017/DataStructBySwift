//
//  78_子集.swift
//  DataStruct
//
//  Created by lijian on 2019/8/2.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_78_子集 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        let n = nums.count
        for i in  0 ..< 1<<n {  //循环nums
            var sub = [Int]()
            for j in 0 ..< n { //子集合的长度
                if ((i>>j)&1) == 1 {
                    sub.append(nums[j])
                }
            }
            res.append(sub)
        }
        return res
    }
}

extension Solution_78_子集 {
    static func test() {
        let instance = Solution_78_子集()
        print(instance.subsets([1,2,3,4]))
        print("测试完成")
    }
}
