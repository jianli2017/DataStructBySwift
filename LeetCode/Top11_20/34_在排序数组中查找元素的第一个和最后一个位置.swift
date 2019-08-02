//
//  34_在排序数组中查找元素的第一个和最后一个位置.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。

你的算法时间复杂度必须是 O(log n) 级别。

如果数组中不存在目标值，返回 [-1, -1]。

示例 1:

输入: nums = [5,7,7,8,8,10], target = 8
输出: [3,4]
示例 2:

输入: nums = [5,7,7,8,8,10], target = 6
输出: [-1,-1]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution_34_在排序数组中查找元素的第一个和最后一个位置 {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        
        let start = BSearch.search_first_equel_target(a: nums, target: target)
        if start == -1 {
            return [-1 , -1]
        }
        let end = BSearch.search_last_equel_target(a: nums, target: target)
        return [start,end]
    }
}

extension Solution_34_在排序数组中查找元素的第一个和最后一个位置 {
    static func test() {
        let instance = Solution_34_在排序数组中查找元素的第一个和最后一个位置()
        print(instance.searchRange([5,7,7,8,8,10], 8))
        
        print(instance.searchRange([5,7,7,8,8,10], 6))
        
        print("测试完成")
    }
}
