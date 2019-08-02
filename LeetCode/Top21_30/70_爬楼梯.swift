//
//  70_爬楼梯.swift
//  DataStruct
//
//  Created by lijian on 2019/7/31.
//  Copyright © 2019 lijian. All rights reserved.
//

/*
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
 
 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
 
 注意：给定 n 是一个正整数。
 
 示例 1：
 
 输入： 2
 输出： 2
 解释： 有两种方法可以爬到楼顶。
 1.  1 阶 + 1 阶
 2.  2 阶
 示例 2：
 
 输入： 3
 输出： 3
 解释： 有三种方法可以爬到楼顶。
 1.  1 阶 + 1 阶 + 1 阶
 2.  1 阶 + 2 阶
 3.  2 阶 + 1 阶
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/climbing-stairs
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import Foundation

class Solution_70_爬楼梯 {
    func climbStairs(_ n: Int) -> Int {
        guard n>0 else {
            return 0
        }
        if  n == 1 {
            return 1
        }
        
        if n == 2 {
            return 2
        }
        var status = [Int](repeating: 0, count: n)
        status[0] = 1
        status[1] = 2
        var i = 2
        while i<n {
            status[i] = status[i-1] + status[i-2]
            i += 1
        }
        return status[n-1]
    }
}

extension Solution_70_爬楼梯 {
    static func test() {
        let instance = Solution_70_爬楼梯()
        assert(instance.climbStairs(2) == 2)
        
        assert(instance.climbStairs(3) == 3)
        
        print("测试完成")
        
        
        
        
        func testDic()->[String] {
            let dic = [
                "1":"11",
                "2":"22"
            ]
            print(dic.values)
            return Array<String>(dic.values)
        }
        
    }
}
