//
//  BSearch.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class BSearch {
    //查找第一个值等于给定值的元素
    static func search_first_equel_target(a: [Int], target: Int) -> Int {
        var low = 0
        var high = a.count - 1
        while low <= high {
            let mid = low + (high-low)>>1
            if a[mid] > target {  //前半部分
                high = mid - 1
            } else if a[mid] < target { //后半部分
                low = low + 1
            } else {
                if mid == 0 || a[mid-1] != target {
                    return mid
                } else { //target 在前半部分
                    high = mid - 1
                }
            }
        }
        return -1
    }
    
    //查找最后一个值等于给定值的元素
    static func search_last_equel_target(a: [Int], target: Int) -> Int {
        var low = 0
        let n = a.count
        var high = n - 1
        while low <= high {
            let mid = low + (high-low)>>1
            if a[mid] > target {  //前半部分
                high = mid - 1
            } else if a[mid] < target { //后半部分
                low = low + 1
            } else {
                if mid == n-1 || a[mid+1] != target {
                    return mid
                } else { //target 在后半部分
                    low = mid + 1
                }
            }
        }
        return -1
    }
}
