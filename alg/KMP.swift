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
        let aa = Array(a.unicodeScalars)
        let bb = Array(b.unicodeScalars)
        let next = getNexts(b: b, m: m)
        var j = 0
        
        for i in 0..<n {
            while j > 0 && aa[i] != bb[j] {
                j = next![j-1] + 1
            }
            
            if aa[i] == bb[j] {
                j += 1
            }
            if j == m {
                return i - m + 1
            }
        }
        return -1;
    }
    
    /*b 表示模式串，表示模式串的长度
     */
    func getNexts(b: String, m: Int) -> [Int]? {
        let bb = Array(b.unicodeScalars)
        var next:[Int] = Array(repeating: -1, count: m)  //定义失效函数
        var k = -1
        for i in 0..<m {
            while k != -1 && bb[k+1] != bb[i] {
                k = next[k]
            }
            
            if bb[k+1] == bb[i] {
                k += 1
            }
            next[k] = k
        }
        return next
    }
    
    static func testKMP() {
        let aa = "lijian66123李李李李"
        let bb = "123李"
        let kmp = KMP()
        
        let c = kmp.kmp(a: aa, n: aa.count, b: bb, m: bb.count)
        
        print(c)
        
    }
    
}
