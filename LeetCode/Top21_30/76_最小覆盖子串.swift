//
//  76_最小覆盖子串.swift
//  DataStruct
//
//  Created by lijian on 2019/8/2.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_76_最小覆盖子串 {
    func minWindow(_ s: String, _ t: String) -> String {
        guard s.count>0 , t.count>0 else {
            return ""
        }
        
        let _s = [Character](s)
        let _t = [Character](t)
        
        //dictT 保存模板串中每个字符出现的个数
        var dictT = [Character:Int]()
        for c in _t {
            let count = dictT[c];
            if count != nil {
                dictT[c] = count! + 1
            } else {
                dictT[c] = 1
            }
        }
        
        // Number of unique characters in t, which need to be present in the desired window.
        // 模板中所有独特字符,这些字符都需要在模板中出现
        let required = dictT.count
        
        // Left and Right pointer
        var l = 0, r = 0;

        
        // formed is used to keep track of how many unique characters in t
        // are present in the current window in its desired frequency.
        // e.g. if t is "AABC" then the window must have two A's, one B and one C.
        // Thus formed would be = 3 when all these conditions are met.
        //formed 统计模板中有多少个字符满足模板中要求频率
        var formed = 0;
        
        // Dictionary which keeps a count of all the unique characters in the current window.
        //窗口中每个字符对应的频率
        var windowCount = [Character: Int]()
        
        // ans list of the form (window length, left, right)
        var ans = [-1, 0, 0];
        
        while r < _s.count {  //右指针的位置
            let cr = _s[r]
            
            if dictT[cr] == nil {
                r += 1
                continue
            }
            //增加窗口中，c的频率
            let countR = windowCount[cr];
            if countR != nil {
                windowCount[cr] = countR! + 1
            } else {
                windowCount[cr] = 1
            }
            
            // If the frequency of the current character added equals to the
            // desired count in t then increment the formed count by 1.
            //如果cr字符在模板中，并且添加后，cr字符在窗口中的个数达到了模板中的个数，form增加1
            if dictT[cr] != nil && windowCount[cr]! == dictT[cr]! {
                formed += 1
            }
            
            while l <= r && formed == required { //满足模板字符的个数要求，开始尝试左指针减少
                let cl = _s[l]
                
                if dictT[cl] == nil {
                    l += 1
                    continue
                }
                if ans[0] == -1 || r - l + 1 < ans[0] {  //保存最小的匹配结果
                    ans[0] = r - l + 1
                    ans[1] = l
                    ans[2] = r
                }
                
                // The character at the position pointed by the
                // `Left` pointer is no longer a part of the window.
                //左指针开始向右移动，缩小窗口
                windowCount[cl] = windowCount[cl]! - 1;
                if dictT[cl] != nil && windowCount[cl]! < dictT[cl]! {
                    formed -= 1
                }
                // Move the left pointer ahead, this would help to look for a new window.
                l += 1
            }
            
            // Keep expanding the window once we are done co***acting.
            r += 1;
        }
        if ans[0] == -1 {
            return ""
        }
        return String(_s[ans[1]...ans[2]])
    }
}

extension Solution_76_最小覆盖子串 {
    static func test() {
        let instance = Solution_76_最小覆盖子串()
        print(instance.minWindow("ADOBECODEBANC", "ABC"))
        print("测试完成")
    }
}
