//
//  LinkLIst_24_Swap_Nodes_in_Pairs.swift
//  DataStruct
//
//  Created by lijian on 2019/6/26.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkLIst_24_Swap_Nodes_in_Pairs: LeetCode_LinkList {
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let node = ListNode(0)
        var pre = node
        pre.next = head
        while let a = pre.next, let b = pre.next?.next {
            (pre.next, a.next , b.next) = (b, b.next, a)
            pre = a
        }
        return node.next
    }
    
    
    func swapPairs1(_ head: ListNode?) -> ListNode? {
        let internalHead  = head?.next ?? head
        var cur = head
        var pre: ListNode?
        while cur != nil  {
            let next = cur!.next
            if next == nil { //有两个元素，可以交换
                break
            }
            let grand = next?.next //孙子节点
            
            next?.next = cur
            cur?.next = grand
            pre?.next = next
            
            pre = cur
            cur = grand
        }
        return internalHead
    }
    
    static func testSwapPairs() {
        let  instance = LinkLIst_24_Swap_Nodes_in_Pairs()
        let node = instance.createNode([1,2,3,4])
        var ret = instance.swapPairs(node?.next)

        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 Given a linked list, swap every two adjacent nodes and return its head.
 
 You may not modify the values in the list's nodes, only nodes itself may be changed.
 
 
 
 Example:
 
 Given 1->2->3->4, you should return the list as 2->1->4->3.
 */
