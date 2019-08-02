//
//  5_最长回文子串.swift
//  DataStruct
//
//  Created by lijian on 2019/7/26.
//  Copyright © 2019 lijian. All rights reserved.
//
/*
给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

示例 1：

输入: "babad"
输出: "bab"
注意: "aba" 也是一个有效答案。
示例 2：

输入: "cbbd"
输出: "bb"

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/longest-palindromic-substring
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
import Foundation
class solution_5_最长回文子串 {
    //下面的算法 时间超限制
   /* func longestPalindrome(_ s: String) -> String {
        var subPalindrome = ""
        var maxLen = 0
        var state = [[Bool]](repeating: [Bool](repeating: false, count: s.count), count: s.count)
        for i in stride(from: s.count-1, through: 0, by: -1) {
            for j in i..<s.count {
                state[i][j] = s[s.ljIndex(i)] == s[s.ljIndex(j)]&&(j-i<3||state[i+1][j-1]);//小于3是因为aba一定是回文
                if state[i][j] && maxLen<(j-i+1) {
                    maxLen = j-i+1
                    subPalindrome = String(s[s.ljIndex(i)...s.ljIndex(j)])
                }
            }
        }
        return subPalindrome
    }*/
    func longestPalindrome(_ s: String) -> String {
        let ss = [Character](s)
        var subPalindrome = ""
        var maxLen = 0
        var state = [[Bool]](repeating: [Bool](repeating: false, count: s.count), count: s.count)
        for i in stride(from: s.count-1, through: 0, by: -1) {
            for j in i..<s.count {
                state[i][j] = (ss[i] == ss[j])&&(j-i<3||state[i+1][j-1]);//小于3是因为aba一定是回文
                if state[i][j] && maxLen<(j-i+1) {
                    maxLen = j-i+1
                    subPalindrome = String(s[s.ljIndex(i)...s.ljIndex(j)])
                }
            }
        }
        return subPalindrome
    }
}
extension solution_5_最长回文子串 {
    static func test() {
        let instance = solution_5_最长回文子串()
//        print(instance.longestPalindrome("babad"))
//        print(instance.longestPalindrome("cbbd"))
        print(instance.longestPalindrome("abcda"))
    print(instance.longestPalindrome("civilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth"))

    }
}

