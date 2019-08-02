//
//  32_最长有效括号.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
给定一个只包含 '(' 和 ')' 的字符串，找出最长的包含有效括号的子串的长度。

示例 1:

输入: "(()"
输出: 2
解释: 最长有效括号子串为 "()"
示例 2:

输入: ")()())"
输出: 4
解释: 最长有效括号子串为 "()()"

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/longest-valid-parentheses
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution_32_最长有效括号 {
    func longestValidParentheses(_ s: String) -> Int {
        var maxLen = 0
        var states = [Int](repeating: 0, count: s.count)
        let _ss = [Character](s)
        var i = 1
        let lenght = s.count
        while i < lenght {
            if _ss[i] == ")" {
                if _ss[i-1] == "(" {  //dp[i]=dp[i−2]+2
                    states[i] = (i >= 2 ? states[i - 2] : 0) + 2
                } else if i-states[i-1]>0 && _ss[i - states[i - 1] - 1] == "(" {
                    //dp[i]=dp[i−1]+dp[i−dp[i−1]−2]+2
                     states[i] = states[i - 1] + ((i - states[i - 1]) >= 2 ? states[i - states[i - 1] - 2] : 0) + 2
                }
            }
            maxLen = max(maxLen, states[i])
            i += 1
        }
        return maxLen
    }
}

extension Solution_32_最长有效括号 {
    static func test() {
        let instance = Solution_32_最长有效括号()
        assert(instance.longestValidParentheses("(()") == 2)
        
        assert(instance.longestValidParentheses(")()())") == 4)
        print("测试完成")
    }
}
