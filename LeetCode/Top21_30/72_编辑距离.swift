//
//  72_编辑距离.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_72_编辑距离 {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        
        let row = word1.count
        let column = word2.count
        let _word1 = [Character](word1)
        let _word2 = [Character](word2)
        
        if row * column == 0 {
            return row + column
        }
        
        var status = [[Int]](repeating: [Int](repeating: 0, count: column+1), count: row+1)
        var i = 1
        var j = 1
        while i < row+1 {
            status[i][0] = i
            i += 1
        }
        while j < column+1 {
            status[0][j] = j
            j += 1
        }
        
        i = 1
        while i < row + 1 {
            j = 1
            while j < column + 1 {
                if _word1[i-1] == _word2[j-1] {
                    status[i][j] =  status[i-1][j-1]
                } else {
                    status[i][j] =  min(status[i-1][j-1], status[i][j-1], status[i-1][j]) + 1
                }
                j += 1
            }
            
            i += 1
        }
        return status[row][column]
    }
}

extension Solution_72_编辑距离 {
    static func test() {
        let instance = Solution_72_编辑距离()
        assert(instance.minDistance("horse", "ros") == 3)
        assert(instance.minDistance("intention", "execution") == 5)
        print("测试完成")
    }
}
