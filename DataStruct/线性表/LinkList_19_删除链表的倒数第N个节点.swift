//
//  LinkList_19_删除链表的倒数第N个节点.swift
//  DataStruct
//
//  Created by lijian on 2019/6/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

class LinkList_19_删除链表的倒数第N个节点: LeetCode_LinkList {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var node: ListNode? = head  //循环变量
        var count = 0
        
        //计算总数
        while node != nil {
            count += 1
            node = node!.next
        }
        
        count = count - n > 0 ? count - n : 0
        
        //查找删除的元素
        node = head
        if count-1 >= 0 {
            //找到前一个元素
            for _ in 0..<count-1 {
                node = node?.next
            }
            node?.next = node?.next?.next
            node = head
        } else { //首元素
            node = head?.next
        }
        return node
    }
    
    fileprivate func removeNthFromEnd2(_ head: ListNode?, _ n: Int) -> ListNode? {
        var node: ListNode? = head  //循环变量
        var ary: [ListNode] = Array()
        
        node = head
        while node != nil {
            ary.append(node!)
            if ary.count > n + 1 {
                ary.removeFirst()
            }
            node = node?.next
        }
        
        if ary.count == n + 1 {
            node = ary.first
            node?.next = node?.next?.next
            node = head
        } else {
            node = head?.next
        }
        ary.removeAll()
        return node
    }
    
    static func testRemoveNthFromEnd() {
        
        //添加测试元素
        //期望：1->2->3->4->5
        let instance = LinkList_19_删除链表的倒数第N个节点()
        let node:ListNode? = instance.createNode([1,2,3,4,5])

        var ret = instance.removeNthFromEnd2(node?.next, 2)
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

示例：

给定一个链表: 1->2->3->4->5, 和 n = 2.

当删除了倒数第二个节点后，链表变为 1->2->3->5.
说明：

给定的 n 保证是有效的。

进阶：

你能尝试使用一趟扫描实现吗？

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
