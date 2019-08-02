//
//  56_合并区间.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

/*
 给出一个区间的集合，请合并所有重叠的区间。
 
 示例 1:
 
 输入: [[1,3],[2,6],[8,10],[15,18]]
 输出: [[1,6],[8,10],[15,18]]
 解释: 区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].
 示例 2:
 
 输入: [[1,4],[4,5]]
 输出: [[1,5]]
 解释: 区间 [1,4] 和 [4,5] 可被视为重叠区间。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-intervals
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */



import Foundation


class Solution_56_合并区间 {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        //先排序
        let newIntervals = intervals.sorted { (a, b) -> Bool in
            a.first! < b.first!
        }
        
        var res = [[Int]]()
        for interval in newIntervals {
            if res.isEmpty || res.last!.last! < interval.first! {
                res.append(interval)
            } else {  //需要合并吧
                var a = res.removeLast()
                a[1] = max(a[1], interval.last!)
                res.append(a)
            }
        }
        return res
    }
}

extension Solution_56_合并区间 {
    static func test() {
        let instance = Solution_56_合并区间()
        print(instance.merge([[1,3],[2,6],[8,10],[15,18]]))
        print("测试完成")
    }
}
