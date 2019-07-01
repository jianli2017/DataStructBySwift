//
//  LinkList_234_Palindrome_Linked_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_234_Palindrome_Linked_List: LeetCode_LinkList {
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard head != nil, head?.next != nil else {
            return true
        }
        var (first,second) = partition(head)
        second = reverseList(second)
        while first != nil {
            if first!.val != second?.val {
                return false
            }
            first = first?.next
            second = second?.next
        }
        return true
    }
    
    /*  查找中间节点，分为两个链表
     这里一定要注意，一定均分， 用pre标记前一个，不然死循环*/
    func partition(_ head: ListNode?) -> (ListNode?, ListNode?) {
        guard head != nil else {
            return (nil, nil)
        }
        var fast = head
        var slow = head
        var pre: ListNode? = head
        
        while fast != nil && fast?.next != nil {
            pre = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        let second = pre?.next
        pre?.next = nil
        return (head, second)
    }
    
    //反转链表
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
    
    
    static func testIsPalindrome() {
        let  instance = LinkList_234_Palindrome_Linked_List()
//        let node = instance.createNode([1,2,2,1])
//        let node = instance.createNode([1,2])
        let node = instance.createNode([1,1])
        let ret = instance.isPalindrome(node?.next)
        print("最终结果：  \(String(describing: ret))")
    }
    
}

/*
 请判断一个链表是否为回文链表。
 
 示例 1:
 
 输入: 1->2
 输出: false
 示例 2:
 
 输入: 1->2->2->1
 输出: true
 进阶：
 你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/palindrome-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
