//
//  LinkList_2_两数相加.swift
//  DataStruct
//
//  Created by lijian on 2019/6/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

//https://leetcode-cn.com/problems/add-two-numbers/
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


extension LinkList where E == Int   {
    fileprivate typealias  ListNode = Node
    fileprivate func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        //新建引用的目的是让入参不变
        var node1:ListNode? = l1
        var node2:ListNode? = l2
        var carry: Int = 0  //保存进位
        var ret: ListNode?  //返回链表的头指针
        var sumList:ListNode? //返回链表的循环指针
        
        while node1 != nil ||  node2 != nil || carry != 0 {
            //计算两数之和
            let sum: Int = (node1?.element ?? 0) + carry + ((node2?.element) ?? 0 )
            //创建一个新节点
            let newNode = ListNode(element: sum >= 10 ? sum - 10 : sum, next: nil)
            if sumList != nil {
                sumList?.next = newNode
                sumList = newNode
            } else {
                sumList = newNode
                ret = newNode
            }
    
            carry = sum/10
            
            node1 = node1?.next
            node2 = node2?.next
        }
        return ret
    }
    
    static func testaddTwoNumbers() {
        let linkList1 = LinkList<Int>()
        
        //添加测试元素
        //期望：2 -> 4 -> 3
        linkList1.add(index: 0, element: 2)
        linkList1.add(index: 1, element: 4)
        linkList1.add(index: 2, element: 3)
        linkList1.add(index: 3, element: 5)
        
        
        let linkList2 = LinkList<Int>()
        
        //添加测试元素
        //期望：2 -> 4 -> 3
        linkList2.add(index: 0, element: 5)
        linkList2.add(index: 1, element: 6)
        linkList2.add(index: 2, element: 4)
        linkList2.add(index: 3, element: 5)

        var ret = linkList1.addTwoNumbers(linkList1.first, linkList2.first)
        while ret != nil {
            print("最终结果：  \(ret!.element)")
            ret = ret?.next
        }
    }
}
