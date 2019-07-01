//
//  LinkList_83_Remove_Duplicates from_Sorted_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_83_Remove_Duplicates_from_Sorted_List: LeetCode_LinkList {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        return findNext(head)
    }
    
    func findNext(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        
        var next: ListNode? = head?.next
        if  head?.val == next?.val {
            while next != nil {  //循环找到下一个不一样的
                if head?.val != next?.val {
                    break
                }
                next = next?.next
            }
        }
        head?.next=findNext(next);
        return head;
    }
    
    
    static func testDeleteDuplicates() {
        let  instance = LinkList_83_Remove_Duplicates_from_Sorted_List()
        
        
//        let node = instance.createNode([1,2,3,3,4,4,5])
                let node = instance.createNode([1,1,1,2,3])
        var ret = instance.deleteDuplicates(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}
/*
Given a sorted linked list, delete all duplicates such that each element appear only once.

Example 1:

Input: 1->1->2
Output: 1->2
Example 2:

Input: 1->1->2->3->3
Output: 1->2->3
*/
