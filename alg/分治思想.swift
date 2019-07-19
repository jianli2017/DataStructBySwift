//
//  分治思想.swift
//  DataStruct
//
//  Created by lijian on 2019/7/17.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Division {
    var num = 0
    func count(a: inout [Int], count: Int) -> Int {
        num = 0
        mergeSortCounting(a: &a, p: 0, r: count - 1 )
        return num
    }
    
    func mergeSortCounting(a: inout [Int], p: Int, r: Int) {
        if p >= r {
            return
        }
        
        let q = (p + r) / 2
        mergeSortCounting(a: &a, p: p, r: q)
        mergeSortCounting(a: &a, p: q+1, r: r)
        merge(a: &a, p: p, q: q, r: r)
    }
    
    func merge(a: inout [Int], p: Int, q: Int, r: Int) {
        var i = p
        var j = q + 1
        var k = 0
        
        var temp: [Int] = Array(repeating: 0, count: r-p+1)
        
        while i <= q && j <= r {
            if a[i] <= a[j] {
                temp[k] = a[i]
                i += 1
            } else {
                num += (q - i + 1)
                temp[k] = a[j]
                j += 1
            }
            k += 1
        }
        
        while i <= q {
            temp[k] = a[i]
            i += 1
            k += 1
        }
        
        while j <= r {
            temp[k] = a[j]
            j += 1
            k += 1
        }
        
        for i in 0 ... r-p {
            a[p+i] = temp[i]
        }
    }
    
    static func testDivision() {
        var a = [2,4,3,1,5,6]
        let division = Division()
        print(division.count(a: &a, count: 6))
    }
}
