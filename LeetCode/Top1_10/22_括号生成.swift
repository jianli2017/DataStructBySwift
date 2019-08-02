//
//  22_括号生成.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
给出 n 代表生成括号的对数，请你写出一个函数，使其能够生成所有可能的并且有效的括号组合。

例如，给出 n = 3，生成结果为：

[
"((()))",
"(()())",
"(())()",
"()(())",
"()()()"
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/generate-parentheses
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

class Solution_22_括号生成 {
    func generateParenthesis(_ n: Int) -> [String] {
        backtrack("", 0, 0, n)
        return ret
    }
    var ret = [String]()
    func backtrack(_ cur: String, _ open: Int, _ close: Int, _ max: Int)  {
        if cur.count == max*2 {
            ret.append(cur)
            return
        }
        if open < max {
            backtrack(cur + "(", open+1, close, max)
        }
        if close < open {
            backtrack(cur + ")", open, close+1, max)
        }
    }
}

extension Solution_22_括号生成 {
    static func test() {
        let instance = Solution_22_括号生成()
        print(instance.generateParenthesis(3))
    }
}


