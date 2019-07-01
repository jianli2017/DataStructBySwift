//
//  LinkList_25_Reverse_Nodes_in_k_Group.swift
//  DataStruct
//
//  Created by lijian on 2019/6/26.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_25_Reverse_Nodes_in_k_Group: LeetCode_LinkList {
    
    /*
     递推公式 node.next = revert(node)  结束条件 node为空
    */
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        return reverse(head, k)
    }
    
    func reverse(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil else {
            return head
        }
        var cur = head
        var leftCount = 0  //剩余个数
        while cur != nil && leftCount < k {
            leftCount += 1
            cur = cur!.next
        }
        
        if leftCount < k {
            return head
        }
        
        //反转K个数据
        cur = head
        var pre: ListNode?
        var temp: ListNode?
        while cur != nil && leftCount > 0 {
            temp = cur!.next
            cur!.next = pre
            pre = cur
            cur = temp
            leftCount -= 1
        }
        head?.next = reverse(cur, k)
        return pre
    }
    static func testReverseKGroup() {
        let  instance = LinkList_25_Reverse_Nodes_in_k_Group()
        let node = instance.createNode([1,2,3,4,5])
        var ret = instance.reverseKGroup(node?.next, 2)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}


/*
 
 给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
 
 k 是一个正整数，它的值小于或等于链表的长度。
 
 如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
 
 示例 :
 
 给定这个链表：1->2->3->4->5
 
 当 k = 2 时，应当返回: 2->1->4->3->5
 
 当 k = 3 时，应当返回: 3->2->1->4->5
 
 说明 :
 
 你的算法只能使用常数的额外空间。
 你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-nodes-in-k-group
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
