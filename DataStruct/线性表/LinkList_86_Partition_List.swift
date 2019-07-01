//
//  LinkList_86_Partition_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_86_Partition_List: LeetCode_LinkList {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var newHead = ListNode(0)
        newHead.next = head
        
        //定义前一个和循环变量
        var pre: ListNode? = newHead
        var cur: ListNode? = newHead.next
        var insertPos: ListNode?
        
        while cur != nil {
            if insertPos == nil && cur!.val >= x {
                insertPos = pre
            }
            
            if cur!.val < x && insertPos != nil {
                //先删除这个元素
                pre?.next = cur!.next
                
                //添加元素
                cur?.next = insertPos?.next
                insertPos?.next = cur
                
                //插入位置后移动
                insertPos = insertPos?.next
                
                //启动下轮循环
                cur = pre?.next
                continue
            }
            pre = cur
            cur = cur?.next
        }
        return newHead.next
    }
    
    static func testPartition() {
        let  instance = LinkList_86_Partition_List()
        let node = instance.createNode([2,1])
        var ret = instance.partition(node?.next, 2)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}
/*
Given a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

You should preserve the original relative order of the nodes in each of the two partitions.

Example:

Input: head = 1->4->3->2->5->2, x = 3
Output: 1->2->2->4->3->5
 
 给一个链表，将小于值x的结点放到所有大于等于值x的结点的前面，不要改变结点之间的顺序（例如1,4,3,2,5,2 将2结点提到至4的前面，但4,3,5的顺序不变）；
*/
