//
//  LinkList_445_Add_Two_Numbers_II.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_445_Add_Two_Numbers_II: LeetCode_LinkList {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var stack1: [Int] = []
        var stack2: [Int] = []
        var node1 = l1
        while node1 != nil {
            stack1.append(node1!.val)
            node1 = node1?.next
        }
        
        var node2 = l2
        while node2 != nil {
            stack2.append(node2!.val)
            node2 = node2?.next
        }
        
        var flag = 0
        var newHead:ListNode?
        while !stack1.isEmpty || !stack2.isEmpty || flag != 0  {
            if !stack1.isEmpty {
                flag += stack1.removeLast()
            }
            
            if !stack2.isEmpty {
                flag += stack2.removeLast()
            }
            let node = ListNode(flag > 9 ? flag - 10 : flag)
            node.next = newHead
            newHead = node
            flag = flag > 9 ? 1 : 0
        }
        return newHead
    }
    
    static func testAddTwoNumbers() {
        let  instance = LinkList_445_Add_Two_Numbers_II()
        let node1 = instance.createNode([7,2,4,3])
        let node2 = instance.createNode([5,6,4])
        var ret = instance.addTwoNumbers(node1?.next,node2?.next)
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 给定两个非空链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储单个数字。将这两数相加会返回一个新的链表。
 
   
 
 你可以假设除了数字 0 之外，这两个数字都不会以零开头。
 
 进阶:
 
 如果输入链表不能修改该如何处理？换句话说，你不能对列表中的节点进行翻转。
 
 示例:
 
 输入: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出: 7 -> 8 -> 0 -> 7
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
