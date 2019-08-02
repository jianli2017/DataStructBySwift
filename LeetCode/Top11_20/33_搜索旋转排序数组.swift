//
//  33_搜索旋转排序数组.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Solution_33_搜索旋转排序数组 {
    func search(_ nums: [Int], _ target: Int) -> Int {
        //查找旋转点
        func find_rotate_index(left: Int, right: Int) -> Int {
            if nums[left] < nums[right] {
                return 0
            }
            var _left = left
            var _right = right
            while _left<=_right {
                let pivot = (_left + _right)/2
                if nums[pivot] > nums[pivot+1] {
                    return pivot+1
                } else {
                    if nums[pivot] < nums[_left] {
                        _right = pivot - 1
                    } else {
                        _left = pivot + 1
                    }
                }
            }
            return 0
        }
        
        //二分搜索
        func search(left: Int, right: Int) -> Int {
            var _left = left
            var _right = right
            while  _left <= _right {
                let pivot = (_left + _right)/2
                if nums[pivot] == target {
                    return pivot
                } else {
                    if target < nums[pivot] {
                        _right = pivot - 1
                    } else {
                        _left = pivot + 1
                    }
                }
            }
            return -1
        }
        
        //函数主题部分
        let n = nums.count
        if n == 0 {
            return -1
        }
        if n == 1 {
            return nums[0] == target ? 0 : -1
        }
        
        let rotate_index = find_rotate_index(left: 0, right: n-1)
        //如果目标数字是最小的元素
        if nums[rotate_index] == target {
            return rotate_index
        }
        
        //如果数组没有旋转，在整个数组中搜索
        if rotate_index == 0 {
            return search(left: 0 , right: n-1)
        }
        
        if target < nums[0] { //在后半部分搜索
            return search(left: rotate_index, right: n-1)
        } else { //前半部分搜索
            return search(left: 0, right: rotate_index)
        }
    }
    
}

extension Solution_33_搜索旋转排序数组 {
    static func test() {
        let instance =  Solution_33_搜索旋转排序数组()
        let result =  instance.search([4,5,6,7,0,1,2], 0)
        assert(result == 4)
        
        let result2 =  instance.search([4,5,6,7,0,1,2], 3)
        assert(result2 == -1)
        
        print("测试完成")
    }
}
