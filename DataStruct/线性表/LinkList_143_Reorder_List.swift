//
//  LinkList_143_Reorder_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_143_Reorder_List: LeetCode_LinkList {
    
    func reorderList(_ head: ListNode?)  {
        guard head != nil && head?.next != nil else {
            return
        }
        
        var fast = head
        var slow = head
        // 找到中间结点
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        var second = slow?.next
        // 注意置空，分为两个链表
        // 第一个链表的长度大于（+1）等于第二个链表长度
        slow?.next = nil
        second = reverseList(second)
        var first = head
        while second != nil {
            let temp = first?.next
            first?.next = second
            second = second?.next
            first = first?.next
            first?.next = temp
            first = first?.next
        }
    }
    
 
    func reverseList(_ head: ListNode?) -> ListNode? {
        var pre: ListNode?
        var cur: ListNode? = head
        while cur != nil {
            let temp:ListNode? = cur!.next
            cur!.next = pre
            pre = cur
            cur = temp
        }
        return pre
    }
    
    
    static func testReorderList() {
        let  instance = LinkList_143_Reorder_List()
        var node = instance.createNode([1,2,3,4,5 ])
        instance.reorderList(node?.next)
        node = node?.next
        while node != nil {
            print("最终结果：  \(node!.val)")
            node = node?.next
        }
    }
}
/*
给定一个单链表 L：L0→L1→…→Ln-1→Ln ，
将其重新排列后变为： L0→Ln→L1→Ln-1→L2→Ln-2→…

你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。

示例 1:

给定链表 1->2->3->4, 重新排列为 1->4->2->3.
示例 2:

给定链表 1->2->3->4->5, 重新排列为 1->5->2->4->3.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reorder-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
