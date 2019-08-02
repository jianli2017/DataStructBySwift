//
//  49_字母异位词分组.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
 给定一个字符串数组，将字母异位词组合在一起。字母异位词指字母相同，但排列不同的字符串。
 
 示例:
 
 输入: ["eat", "tea", "tan", "ate", "nat", "bat"],
 输出:
 [
 ["ate","eat","tea"],
 ["nat","tan"],
 ["bat"]
 ]
 说明：
 
 所有输入均为小写字母。
 不考虑答案输出的顺序。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/group-anagrams
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution_49_字母异位词分组 {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        let len = strs.count
        guard len > 0 else {
            return []
        }
        var res:[String: [String]] = [:] //统计使用的字典
        strs.forEach { (s) in
            let new = String(s.sorted())
            if var diffList = res[new] {
                diffList.append(s)
                res.updateValue(diffList, forKey: new)
            } else {
                res.updateValue([s], forKey: new)
            }
        }
        var result = [[String]]()
        for (key,value) in res {
            result.append(value)
        }
        return result;
        
    }
}

extension Solution_49_字母异位词分组 {
    static func test() {
        let instance = Solution_49_字母异位词分组()
        print(instance.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
        print("测试结束")
    }
}
