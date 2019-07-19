//
//  动态规划实战.swift
//  DataStruct
//
//  Created by lijian on 2019/7/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

extension String {
    func ljIndex(_ distance: Int) ->Index {
        return self.index(self.startIndex, offsetBy: distance)
    }
}
class StringDistance {
    let a = "mitcmu"
    let b = "mtacnu"
    let n = 6
    let m = 6
    var minDis = Int.max
    func lwstBT(i: Int, j:Int , edist: Int)  {
        if i == n || j == m {
            var minEditDidtance = edist
            
            if i < n {
                minEditDidtance += (n - i)
            }
            if j < m {
                minEditDidtance += (m-j)
            }
            if minEditDidtance < minDis {
                minDis = minEditDidtance
            }
            return
        }
        if a[a.ljIndex(i)] == b[b.ljIndex(j)] {
            lwstBT(i: i + 1, j: j+1, edist: edist)
        } else { //两个字符不匹配
            lwstBT(i: i, j: j+1, edist: edist + 1) // 删除 b[j] 或者 a[i] 前添加一个字符
            lwstBT(i: i+1, j: j, edist: edist + 1) // 删除 a[i] 或者 b[j] 前添加一个字符
            lwstBT(i: i+1, j: j+1, edist: edist + 1) // 将 a[i] 和 b[j] 替换为相同字符
        }
    }
    
    
    func lwstDP() -> Int {
        //初始化状态表
        var status = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
        
        //初始状态
        for j in 0..<m { // 初始化第 0 行:a[0..0] 与 b[0..j] 的编辑距离
            if a[a.ljIndex(0)] == b[b.ljIndex(j)] {
                status[0][j] = j
            } else if j != 0 {
                status[0][j] = status[0][j-1]+1
            } else {
                status[0][j] = 1
            }
        }
        
        for i in 0..<n { // 初始化第 0 列:a[0..i] 与 b[0..0] 的编辑距离
            if a[a.ljIndex(i)] == b[b.ljIndex(0)] {
                status[i][0] = i
            } else if i != 0 {
                status[i][0] = status[i-1][0]+1
            } else {
                status[i][0] = 1
            }
        }
        
        for i in 1..<n { // 按行填表
            for j in 1..<m {
                if a[a.ljIndex(i)] == b[b.ljIndex(j)] {
                    status[i][j] = min(status[i-1][j],status[i][j-1],status[i-1][j-1])
                } else {
                     status[i][j] = min(status[i-1][j],status[i][j-1],status[i-1][j-1]) + 1
                }
            }
        }
        return status[n-1][m-1]
    }
    
    func lcs() -> Int {
        //初始化状态表
        var status = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
        
        //初始状态
        for j in 0..<m { // 初始化第 0 行:a[0..0] 与 b[0..j] 的编辑距离
            if a[a.ljIndex(0)] == b[b.ljIndex(j)] {
                status[0][j] = 1
            } else if j != 0 {
                status[0][j] = status[0][j-1]
            } else {
                status[0][j] = 0
            }
        }
        
        for i in 0..<n { // 初始化第 0 列:a[0..i] 与 b[0..0] 的编辑距离
            if a[a.ljIndex(i)] == b[b.ljIndex(0)] {
                status[i][0] = 1
            } else if i != 0 {
                status[i][0] = status[i-1][0]
            } else {
                status[i][0] = 0
            }
        }
        
        for i in 1..<n { // 按行填表
            for j in 1..<m {
                if a[a.ljIndex(i)] == b[b.ljIndex(j)] {
                    status[i][j] = max(status[i-1][j],status[i][j-1],status[i-1][j-1]+1)
                } else {
                    status[i][j] = max(status[i-1][j],status[i][j-1],status[i-1][j-1])
                }
            }
        }
        return status[n-1][m-1]
    }
    
    static func testLwstBT() {
        let instance =  StringDistance()
        instance.lwstBT(i: 0, j: 0, edist: 0)
        print("回溯思想得到的莱文斯坦距离结果：\(instance.minDis)")
        
        print("动态规划得到的莱文斯坦距离结果：\(instance.lwstDP())")
        
        print("动态规划得到的最长公共子串的结果：\(instance.lcs())")
    }
}


