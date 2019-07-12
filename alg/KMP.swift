//
//  KMP.swift
//  DataStruct
//
//  Created by lijian on 2019/7/12.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class KMP {
    /*b 表示模式串，表示模式串的长度
     */
    func getNexts(b: String, m: Int) -> [Int]? {
        var next:[Int] = Array(repeating: -1, count: m)  //定义失效函数
        var k = -1
        for i in 0..<m {
            while k != -1 && b[k+1] != b[i] {
                k = next[k]
            }
            b[i].ch
            if
        }
        
        
        
        
        return nil
    }
}
