//
//  3_无重复字符的最长子串.swift
//  DataStruct
//
//  Created by lijian on 2019/7/25.
//  Copyright © 2019 lijian. All rights reserved.
//
/*
给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

示例 1:

输入: "abcabcbb"
输出: 3
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
示例 2:

输入: "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
示例 3:

输入: "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation
class Solution_3_无重复字符的最长子串 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var max = 0
        var subs = Array<Character>()
        for c in s {
            if subs.contains(c) { //碰到坏字符
                if subs.count > max { //更新最大子串长度
                    max = subs.count
                }
                
                //删除c之前的
                var end = 0
                for (index, value) in subs.enumerated() {
                    if value == c {
                        end = index
                        break
                    }
                }
                subs.removeSubrange(0...end)
            }
            subs.append(c)
        }
        if subs.count > max { //最后跟新一次最大子串
            max = subs.count
        }
        return max
    }
}

extension Solution_3_无重复字符的最长子串 {
    static func test() {
        var instance = Solution_3_无重复字符的最长子串()
        let length = instance.lengthOfLongestSubstring("dvdf")
        print(length)
    }
}
/*
var returnCount = 0
var tempDic = [Character:Int]()
var leftIndex = 0
let chars = Array(s)
for rightIndex in 0..<chars.count {
    let tempOneString = chars[rightIndex]
    if let tempI = tempDic[tempOneString]
    {
        if tempI >= leftIndex
        {
            leftIndex = tempI + 1
        }
    }
    tempDic[tempOneString] = rightIndex
    returnCount = max(rightIndex - leftIndex + 1, returnCount)
}
return returnCount;
 */
