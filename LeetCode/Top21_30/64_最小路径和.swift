//
//  64_最小路径和.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution64_最小路径和 {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid.last!.count
        guard m > 0 ,n > 0 else {
            return 0
        }
        
        var status = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        status[0][0] = grid[0][0]
        var i = 1
        
        while i < m {  //初始化第一行
            status[i][0] = grid[i][0] +  status[i-1][0]
            i += 1
        }
        
        var j = 1
        while j < n { //初始化第一列
            status[0][j] = grid[0][j] +  status[0][j-1]
            j += 1
        }
        
        i = 1
        while i < m {
            j = 1
            while j < n {
                status[i][j] = min(status[i][j-1], status[i-1][j]) + grid[i][j]
                j += 1
            }
            i += 1
        }
        return status[m-1][n-1]
    }
}

extension Solution64_最小路径和 {
    static func test() {
        let instance = Solution64_最小路径和()
        let sample = [
            [1,3,1],
            [1,5,1],
            [4,2,1]
        ]
        assert(instance.minPathSum(sample) == 7)
        let sample2 = [[1,2,5],[3,2,1]]
        instance.minPathSum(sample2)
        
        print("测试结束")
    }
}
