//
//  LinkList_876_Middle_of_the_Linked_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_876_Middle_of_the_Linked_List: LeetCode_LinkList {
    func middleNode(_ head: ListNode?) -> ListNode? {
        let (_,newHead) = partition(head)
        return newHead
    }
    
    func partition(_ head: ListNode?) -> (ListNode?, ListNode?) {
        guard head != nil else {
            return (nil, nil)
        }
        
        guard head?.next != nil else {
            return (nil, head)
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
    
    static func testMiddleNode() {
        let  instance = LinkList_876_Middle_of_the_Linked_List()
//        let node = instance.createNode([1,2,3,4,5,6])
        let node = instance.createNode([1])
        var ret = instance.middleNode(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 给定一个带有头结点 head 的非空单链表，返回链表的中间结点。
 
 如果有两个中间结点，则返回第二个中间结点。
 
   
 
 示例 1：
 
 输入：[1,2,3,4,5]
 输出：此列表中的结点 3 (序列化形式：[3,4,5])
 返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
 注意，我们返回了一个 ListNode 类型的对象 ans，这样：
 ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
 示例 2：
 
 输入：[1,2,3,4,5,6]
 输出：此列表中的结点 4 (序列化形式：[4,5,6])
 由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。
   
 
 提示：
 
 给定链表的结点数介于 1 和 100 之间。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/middle-of-the-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
