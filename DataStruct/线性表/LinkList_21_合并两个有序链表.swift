//
//  LinkList_21_合并两个有序链表.swift
//  DataStruct
//
//  Created by lijian on 2019/6/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_21_合并两个有序链表: LeetCode_LinkList {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let newHead = ListNode(0) //返回的头结点（虚拟头节点）
        var node1: ListNode? = l1
        var node2: ListNode? = l2
        var node: ListNode? = newHead  //新链表的循环变量
        while node1 != nil ||  node2 != nil {
            if node1 != nil && node2 != nil {
                if node1!.val <= node2!.val {
                    node?.next = node1;
                    node1 = node1?.next
                } else {
                    node?.next = node2
                    node2 = node2?.next
                }
            } else {  //处理已经有一个链表为空的情况， 将非空链表链接到node即可
                if node1 != nil {
                    node?.next = node1
                    node1 = node1?.next
                } else {
                    node?.next = node2
                    node2 = node2?.next
                }
                break
            }
            node = node?.next //新链表向后移动
        }
        return newHead.next
    }
    
    static func testMergeTwoLists() {
        let instance = LinkList_21_合并两个有序链表()
        //添加测试元素
        //期望：1->2->4
        let nodeA:ListNode? = instance.createNode([1,2,4])

        
        //添加测试元素
        //期望：1->3->4
        let instanceB = LinkList_21_合并两个有序链表()
        let nodeB:ListNode? = instanceB.createNode([1,3,4])

        
        var ret = instance.mergeTwoLists(nodeA?.next, nodeB?.next)
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}
/*
 将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
 
 示例：
 
 输入：1->2->4, 1->3->4
 输出：1->1->2->3->4->4
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
