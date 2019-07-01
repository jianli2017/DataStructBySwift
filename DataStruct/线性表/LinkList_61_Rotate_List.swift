//
//  LinkList_61_Rotate_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_61_Rotate_List: LeetCode_LinkList {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil else {
            return head
        }
        //构建循环链表
        var last: ListNode? = head
        var count = 0
        var node = head
        while  node != nil {
            last = node! //保存最后一个指针
            count += 1
            node = node!.next
        }
        
        //构建循环链表
        last?.next = head
        
        //左移i位
        var i = count - k%count
        node = head
        while  i > 0 {
            node = node?.next!
            i -= 1
        }
        
        //新的头结点为node
        last = node
        
        //解除循环链表
        while count > 1  {
            last = last?.next
            count -= 1
        }
        last?.next = nil
        return node
    }
    
    static func testRotateRight() {
        let  instance = LinkList_61_Rotate_List()
        let node = instance.createNode([0,1,2])
        var ret = instance.rotateRight(node?.next, 4)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 Given a linked list, rotate the list to the right by k places, where k is non-negative.
 
 Example 1:
 
 Input: 1->2->3->4->5->NULL, k = 2
 Output: 4->5->1->2->3->NULL
 Explanation:
 rotate 1 steps to the right: 5->1->2->3->4->NULL
 rotate 2 steps to the right: 4->5->1->2->3->NULL
 Example 2:
 
 Input: 0->1->2->NULL, k = 4
 Output: 2->0->1->NULL
 Explanation:
 rotate 1 steps to the right: 2->0->1->NULL
 rotate 2 steps to the right: 1->2->0->NULL
 rotate 3 steps to the right: 0->1->2->NULL
 rotate 4 steps to the right: 2->0->1->NULL
 
 */
