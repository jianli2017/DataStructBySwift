//
//  LinkList_203_Remove_Linked_List_Elements.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_203_Remove_Linked_List_Elements: LeetCode_LinkList {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let newHead = ListNode(0)
        newHead.next = head
        var cur = head
        var pre: ListNode? = newHead
        while cur != nil {
            if cur!.val == val { //删除cur节点
                pre?.next = cur?.next
            } else  {
                pre = cur
            }
            cur = cur?.next
        }
        return newHead.next
    }
    static func testRemoveElements() {
        let  instance = LinkList_203_Remove_Linked_List_Elements()
        let node = instance.createNode([1,2,6,3,4,5,6])
        var ret = instance.removeElements(node?.next,6)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 Remove all elements from a linked list of integers that have value val.
 
 Example:
 
 Input:  1->2->6->3->4->5->6, val = 6
 Output: 1->2->3->4->5
 */
