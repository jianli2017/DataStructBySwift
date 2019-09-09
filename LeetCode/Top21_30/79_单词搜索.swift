//
//  79_单词搜索.swift
//  DataStruct
//
//  Created by lijian on 2019/8/14.
//  Copyright © 2019 lijian. All rights reserved.
//

/*

给定一个二维网格和一个单词，找出该单词是否存在于网格中。

单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。

示例:

board =
[
['A','B','C','E'],
['S','F','C','S'],
['A','D','E','E']
]

给定 word = "ABCCED", 返回 true.
给定 word = "SEE", 返回 true.
给定 word = "ABCB", 返回 false.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/word-search
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

*/
import Foundation

class Solution_79_单词搜索 {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count;
        if m == 0 {
            return false
        }
        let n = board[0].count
        var marked = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        let direct = [[0,-1],[-1,0],[0,1],[1,0]]
        let _word = [Character](word)
        
        func dfs(_ i: Int, _ j:Int, _ start: Int)->Bool {
            if start == _word.count - 1 {
                return board[i][j] == _word[start]
            }
            if board[i][j] == _word[start] {
                marked[i][j] = true
                for k in 0..<4 {  //4个方向尝试吧
                    let newX = i + direct[k][0]
                    let newY = j + direct[k][1]
                    if inArea(newX, newY) && !marked[newX][newY] {
                        if dfs(newX, newY, start+1) {
                            return true
                        }
                    }
                }
                marked[i][j] = false
            }
            return false
        }
        
        
        func inArea(_ x: Int, _ y: Int)->Bool {
            return x >= 0 && x < m && y >= 0 && y < n
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if dfs(i, j, 0) {
                    return true;
                }
            }
        }
        return false
    }
}

extension Solution_79_单词搜索 {
    static func test() {
//        print(Int.min)
        let instance = Solution_79_单词搜索()
        assert(instance.exist([ ["A","B","C","E"],
                                ["S","F","C","S"],
                                ["A","D","E","E"]
            ], "ABCCED"))
        
        assert(instance.exist([ ["A","B","C","E"],
                                ["S","F","C","S"],
                                ["A","D","E","E"]
            ], "SEE"))
        
        
        assert(instance.exist([ ["A","B","C","E"],
                                ["S","F","C","S"],
                                ["A","D","E","E"]
            ], "ABCB") == false)
        
        
        assert(instance.exist([ ["C","A","A","E"],
                                ["S","F","C","S"],
                                ["A","D","E","E"]
            ], "ABCB") == false)
        
        [["C","A","A"],["A","A","A"],["B","C","D"]]
        "AAB"
        print("测试完成")
    }
}
