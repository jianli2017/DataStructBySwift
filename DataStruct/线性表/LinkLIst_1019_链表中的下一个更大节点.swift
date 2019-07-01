//
//  LinkLIst_1019_链表中的下一个更大节点.swift
//  DataStruct
//
//  Created by lijian on 2019/6/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
 使用递减栈，保存前面小的索引，遇到大于栈顶，弹出小于当前元素  ，知道大于等于当前元素
 */

class LinkLIst_1019_链表中的下一个更大节点: LeetCode_LinkList {
    func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var list:[Int] = Array()
        var node:ListNode? = head
        while node != nil {
            list.append(node!.val)
            node = node!.next
        }
        
        var ret: [Int] = Array(repeating: 0, count: list.count)
        var stack: [Int] = Array()
        for (index, value) in list.enumerated() {
            while !stack.isEmpty && (list[stack.last!] < value) {
                ret[stack.last!] = value
                stack.removeLast()
            }
            stack.append(index)
        }
        return ret
    }
    
    static func testNextLargerNodes() {
        
        //添加测试元素
        //期望：[2,1,5] [5,5,0]
        let instanc1 = LinkLIst_1019_链表中的下一个更大节点()
        let node1:ListNode? = instanc1.createNode([2,1,5])
        let retAry1 = instanc1.nextLargerNodes(node1?.next)
        print(retAry1)
        
        
        //测试用例2
        //期望：[2,7,4,3,5]  [7,0,5,5,0]
        let instanc2 = LinkLIst_1019_链表中的下一个更大节点()
        let node2:ListNode? = instanc2.createNode([2,7,4,3,5])
        let retAry2 = instanc2.nextLargerNodes(node2?.next)
        print(retAry2)
        
        
        //测试用例3
        //期望：[1,7,5,1,9,2,5,1]  [7,9,9,9,0,5,0,0]
        let instanc3 = LinkLIst_1019_链表中的下一个更大节点()
        let node3:ListNode? = instanc3.createNode([1,7,5,1,9,2,5,1])
        let retAry3 = instanc3.nextLargerNodes(node3?.next)
        print(retAry3)
    }
    
    
}
/*
extension LinkList where E == Int {
    fileprivate typealias ListNode = Node
    
    fileprivate func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var list:[Int] = Array()
        var node:ListNode? = head
        while node != nil {
            list.append(node!.element)
            node = node!.next
        }
        
        var ret: [Int] = Array(repeating: 0, count: list.count)
        var stack: [Int] = Array()
        for (index, value) in list.enumerated() {
            while !stack.isEmpty && (list[stack.last!] < value) {
                ret[stack.last!] = value
                stack.removeLast()
            }
            stack.append(index)
        }
        return ret
    }
        
        
        
        
    //暴力法，无法提交
    fileprivate func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var ret:[Int] = Array()
        var cur: ListNode? = head
        while cur != nil {
            var next: ListNode? = cur!.next
            var nextMax: Int = 0
            while next != nil {
                if cur!.element < next!.element {
                    nextMax = next!.element
                    break
                }
                next = next!.next
            }
            ret.append(nextMax)
            cur = cur!.next
        }
        return ret

    }*/
    /* 算法错误
    fileprivate func nextLargerNodes(_ head: ListNode?) -> [Int] {
        //反转链表
        var pre: ListNode?
        var newHead:ListNode? = head
        while newHead != nil {
            //首先保存next
            let temp: ListNode? = newHead?.next
            newHead?.next = pre
            if temp != nil {
                pre = newHead
                newHead = temp
            } else {
                break
            }
        }
        
        //构造最大值
        var ary: [Int] = Array()
        ary.insert(0, at: 0)
        pre = newHead
        newHead = newHead?.next
        while newHead != nil {
            if newHead!.element > pre!.element {  //找到一个最大值，那么后面就没有比最大的的，所以为0
                ary.insert(0, at: 0)
            } else {
                ary.insert(pre!.element, at: 0)
                newHead?.element =  pre!.element
            }
            pre = newHead
            newHead = newHead?.next

        }
        return ary
    }
 
    static func testNextLargerNodes() {
        
    }
        
}
 */
/*
给出一个以头节点 head 作为第一个节点的链表。链表中的节点分别编号为：node_1, node_2, node_3, ... 。

每个节点都可能有下一个更大值（next larger value）：对于 node_i，如果其 next_larger(node_i) 是 node_j.val，那么就有 j > i 且  node_j.val > node_i.val，而 j 是可能的选项中最小的那个。如果不存在这样的 j，那么下一个更大值为 0 。

返回整数答案数组 answer，其中 answer[i] = next_larger(node_{i+1}) 。

注意：在下面的示例中，诸如 [2,1,5] 这样的输入（不是输出）是链表的序列化表示，其头节点的值为 2，第二个节点值为 1，第三个节点值为 5 。

 

示例 1：

输入：[2,1,5]
输出：[5,5,0]
示例 2：

输入：[2,7,4,3,5]
输出：[7,0,5,5,0]
示例 3：

输入：[1,7,5,1,9,2,5,1]
输出：[7,9,9,9,0,5,0,0]
 

提示：

对于链表中的每个节点，1 <= node.val <= 10^9
给定列表的长度在 [0, 10000] 范围内


来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/next-greater-node-in-linked-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
