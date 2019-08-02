//
//  11_盛最多水的容器.swift
//  DataStruct
//
//  Created by lijian on 2019/7/29.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

说明：你不能倾斜容器，且 n 的值至少为 2。



图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。

 

示例:

输入: [1,8,6,2,5,4,8,3,7]
输出: 49

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/container-with-most-water
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

*/

/*
这种方法背后的思路在于，两线段之间形成的区域总是会受到其中较短那条长度的限制。此外，两线段距离越远，得到的面积就越大。

我们在由线段长度构成的数组中使用两个指针，一个放在开始，一个置于末尾。 此外，我们会使用变量

maxarea 来持续存储到目前为止所获得的最大面积。 在每一步中，我们会找出指针所指向的两条线段形成的区域，更新

maxarea，并将指向较短线段的指针向较长线段那端移动一步。

查看下面的例子将有助于你更好地理解该算法：

*/


class solution_11_盛最多水的容器 {
    func maxArea(_ height: [Int]) -> Int {
        var maxarea = 0
        var l = 0
        var r = height.count - 1
        while l < r {
            maxarea =  max(maxarea, (r - l)*min(height[l], height[r]))
            if height[l] < height[r] {
                l += 1
            } else {
                r -= 1
            }
        }
        return maxarea
    }
}

extension solution_11_盛最多水的容器  {
    static func test() {
        let instance = solution_11_盛最多水的容器()
        print(instance.maxArea([1,8,6,2,5,4,8,3,7]))
    }
}
/*
public int maxArea(int[] height) {
    int maxarea = 0, l = 0, r = height.length - 1;
    while (l < r) {
        maxarea = Math.max(maxarea, Math.min(height[l], height[r]) * (r - l));
        if (height[l] < height[r])
        l++;
        else
        r--;
    }
    return maxarea;
}
*/
