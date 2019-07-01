//
//  LinkList_206_Reverse_Linked_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_206_Reverse_Linked_List: LeetCode_LinkList {
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard  head != nil  else {
            return head
        }
        
        var cur = head
        var pre:ListNode?
        
        while cur != nil {
            let temp = cur!.next
            cur!.next = pre
            pre = cur
            cur = temp
        }
        return pre
    }
    
    func reverseList2(_ head: ListNode?) -> ListNode? {
        guard  head != nil , head?.next != nil else {
            return head
        }
        let next = head?.next
        let newHead =  reverseList2(next)
        next?.next = head
        head?.next = nil
        return newHead
    }
    
    static func testReverseList() {
        let  instance = LinkList_206_Reverse_Linked_List()
        let node = instance.createNode([1,2,3,4,5])
        var ret = instance.reverseList2(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}


/*
 Reverse a singly linked list.
 
 Example:
 
 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL
 Follow up:
 
 A linked list can be reversed either iteratively or recursively. Could you implement both?
 https://leetcode.com/problems/reverse-linked-list/
 
 */

