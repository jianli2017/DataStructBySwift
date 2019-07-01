//
//  LinkList_92_Reverse_Linked_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_92_Reverse_Linked_List: LeetCode_LinkList {
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        let newHead = ListNode(0)
        newHead.next = head
    
        var pre: ListNode?  = newHead//反正使用的前一个节点
        var node: ListNode? = pre?.next //循环节点
        var first:ListNode? //第一个开始反正的节点
        
        var count = 1
        while node != nil {
            if count > m && count <= n { //反转
                let temp = node!.next
                if count == n { //最后一个节点，反转，还有多连接两条线
                    node?.next = pre
                    first?.next?.next = temp
                    first?.next = node
                    break
                } else {
                    node?.next = pre
                    pre = node
                    node = temp
                }
            } else {
                if count == m  { ///记录反转的前一个位置
                    first = pre
                }
                pre = node
                node = node!.next
            }
            count += 1
        }
        return newHead.next
    }
    
    static func testReverseBetween() {
        let  instance = LinkList_92_Reverse_Linked_List()
        let node = instance.createNode([1,2,3,4,5])
        var ret = instance.reverseBetween(node?.next, 2, 4)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}

/*
 反转从位置 m 到 n 的链表。请使用一趟扫描完成反转。
 
 说明:
 1 ≤ m ≤ n ≤ 链表长度。
 
 示例:
 
 输入: 1->2->3->4->5->NULL, m = 2, n = 4
 输出: 1->4->3->2->5->NULL
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
