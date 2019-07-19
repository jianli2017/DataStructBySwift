//
//  KMP.swift
//  DataStruct
//
//  Created by lijian on 2019/7/12.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class KMP {
    func kmp(a: String, n: Int, b: String, m:Int) -> Int {
        let next = getNexts(b: b, m: m)
        var j = 0
        for i in 0..<n {
            while j > 0 && a[a.index(a.startIndex, offsetBy: i)] != b[b.index(b.startIndex, offsetBy: j)] { //处理不等于的情况，i不动，j尽量移动多位
                j = next[j-1] + 1
            }
            
            //相等，继续往后比较
            if a[a.index(a.startIndex, offsetBy: i)] == b[b.index(b.startIndex, offsetBy: j)] {
                j += 1
            }
            
            //查找到了结果
            if j == m {
                return i - m + 1
            }
        }
        return -1;
    }
    
    /*失效函数：  b 表示模式串，m表示模式串的长度*/
    func getNexts(b: String, m: Int) -> [Int] {
        var next:[Int] = Array(repeating: -1, count: m)  //定义失效函数
        var k = -1
        for i in 0..<m {
            while k != -1 && b[b.index(b.startIndex, offsetBy: k+1)] != b[b.index(b.startIndex, offsetBy: i)] {
                k = next[k]
            }
            
            if b[b.index(b.startIndex, offsetBy: k+1)] == b[b.index(b.startIndex, offsetBy: i)] {
                k += 1
            }
            next[k] = k
        }
        return next
    }
    
    static func testKMP() {
        let aa = "lijian66李健123李李李李"
        let bb = "123李"
        let kmp = KMP()
        let c = kmp.kmp(a: aa, n: aa.count, b: bb, m: bb.count)
        print(c)
    }
}
