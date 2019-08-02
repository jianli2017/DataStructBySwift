//
//  10_正则表达式匹配.swift
//  DataStruct
//
//  Created by lijian on 2019/7/29.
//  Copyright © 2019 lijian. All rights reserved.
//

/*
给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。

'.' 匹配任意单个字符
'*' 匹配零个或多个前面的那一个元素
所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。

说明:

s 可能为空，且只包含从 a-z 的小写字母。
p 可能为空，且只包含从 a-z 的小写字母，以及字符 . 和 *。
示例 1:

输入:
s = "aa"
p = "a"
输出: false
解释: "a" 无法匹配 "aa" 整个字符串。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/regular-expression-matching
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


//https://blog.csdn.net/hk2291976/article/details/51165010
import Foundation
//""
//".*"

class solusion_10_正则表达式匹配 {
    
    func isMatch(_ s: String, _ p: String) -> Bool {
        var ss = [Character](s)
        var pp = [Character](p)
        let m = s.count
        let n = p.count
        var states = [[Bool]](repeating: [Bool](repeating: false, count: n+1), count: m+1)
        states[0][0] = true
        //初始化第0行,除了[0][0]全为false，毋庸置疑，因为空串p只能匹配空串，其他都无能匹配
        var i = 1
        while i <= m {
            states[i][0] = false
            i += 1
        }
        //初始化第0列，只有X*能匹配空串，如果有*，它的真值一定和p[0][j-2]的相同（略过它之前的符号）
        var j = 1
        while j <= n {
            states[0][j] = j > 1 && "*" == pp[j - 1] && states[0][j - 2]
            j += 1
        }
        i = 1
        while i <= m {
            j = 1
            while j <= n {
                if pp[j - 1] == "*" {
                    states[i][j] = states[i][j - 2] || (ss[i - 1] == pp[j - 2] || pp[j - 2] == ".") && states[i - 1][j];
                } else { //只有当前字符完全匹配，才有资格传递dp[i-1][j-1] 真值
                    states[i][j] = (pp[j - 1] == "." || ss[i - 1] == pp[j - 1]) && states[i - 1][j - 1];
                }
                j += 1
            }
            i += 1
        }
        return states[m][n]
    }
    
    /*
    func isMatch(_ s: String, _ p: String) -> Bool {
        var ss = [Character](s)
        var pp = [Character](p)
        let m = s.count
        let n = p.count
        var states = [[Bool]](repeating: [Bool](repeating: false, count: n+1), count: m+1)
        states[0][0] = true
        //初始化第0行,除了[0][0]全为false，毋庸置疑，因为空串p只能匹配空串，其他都无能匹配
        var i = 1
        while i <= m {
            states[i][0] = false
            i += 1
        }
        //下面代码崩溃，m=0
        /*for i in 1...m {
            states[i][0] = false
        }*/
        //初始化第0列，只有X*能匹配空串，如果有*，它的真值一定和p[0][j-2]的相同（略过它之前的符号）
//        for j in 1...n {
//            states[0][j] = j > 1 && "*" == pp[j - 1] && states[0][j - 2];
//        }
        var j = 1
        while j <= n {
            states[0][j] = j > 1 && "*" == pp[j - 1] && states[0][j - 2]
            j += 1
        }
        i = 1
        for i in 1...m {
            for j in 1...n {
                if pp[j - 1] == "*" {
                    states[i][j] = states[i][j - 2] || (ss[i - 1] == pp[j - 2] || pp[j - 2] == ".") && states[i - 1][j];
                } else { //只有当前字符完全匹配，才有资格传递dp[i-1][j-1] 真值
                    states[i][j] = (pp[j - 1] == "." || ss[i - 1] == pp[j - 1]) && states[i - 1][j - 1];
                }
            }
        }
        return states[m][n]
    }*/
}
extension solusion_10_正则表达式匹配 {
    static func test() {
        let instance = solusion_10_正则表达式匹配()
        print(instance.isMatch("", ".*"))
    }
}
/*
p.charAt(j) == s.charAt(i) : dp[i][j] = dp[i-1][j-1]
If p.charAt(j) == ‘.’ : dp[i][j] = dp[i-1][j-1];
If p.charAt(j) == ‘*’:
here are two sub conditions:
    if p.charAt(j-1) != s.charAt(i) : dp[i][j] = dp[i][j-2] //in this case, a* only counts as empty
if p.charAt(i-1) == s.charAt(i) or p.charAt(i-1) == ‘.’:
dp[i][j] = dp[i-1][j] //in this case, a* counts as multiple a
dp[i][j] = dp[i][j-1] // in this case, a* counts as single a
dp[i][j] = dp[i][j-2] // in this case, a* counts as empty
*/
