//
//  62_不同路径.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

/*
 问总共有多少条不同的路径？
 
 
 
 例如，上图是一个7 x 3 的网格。有多少可能的路径？
 
 说明：m 和 n 的值均不超过 100。
 
 示例 1:
 
 输入: m = 3, n = 2
 输出: 3
 解释:
 从左上角开始，总共有 3 条路径可以到达右下角。
 1. 向右 -> 向右 -> 向下
 2. 向右 -> 向下 -> 向右
 3. 向下 -> 向右 -> 向右
 示例 2:
 
 输入: m = 7, n = 3
 输出: 28
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/unique-paths
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


import Foundation

class Solution_62_不同路径 {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0 ,n > 0 else {
            return 0
        }
        var status = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {  //初始化第一行
            status[i][0] = 1
        }
        
        for j in 1..<n { //初始化第一列
            status[0][j] = 1
        }
        
        var i = 1
        while i < m {
            var j = 1
            while j < n {
                status[i][j] = status[i][j-1] + status[i-1][j]
                j += 1
            }
            i += 1
        }
        return status[m-1][n-1]
    }
}

extension Solution_62_不同路径 {
    static func test() {
        let instance = Solution_62_不同路径()
        assert(instance.uniquePaths(3, 2) == 3)
        assert(instance.uniquePaths(7, 3) == 28)
        
        print("测试结束")
    }
}
