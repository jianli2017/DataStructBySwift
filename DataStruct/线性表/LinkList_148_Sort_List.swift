//
//  LinkList_148_Sort_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
 递归表达式
 sort(l) = sort(左边) + sort(右边)
 退出条件： 链表的长度为1
 */
class LinkList_148_Sort_List: LeetCode_LinkList {
    func sortList(_ head: ListNode?) -> ListNode? {
        guard head != nil && head?.next != nil else {
            return head
        }
        
        var (first, second) = partition(head)
        first = sortList(first)
        second = sortList(second)
        let ret = mergeTwoLists(first, second)
        return ret
    }
    /*  这里一定要注意，一定均分， 用pre标记前一个，不然死循环*/
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
    
    static func testSortList() {
        let  instance = LinkList_148_Sort_List()
//        let node = instance.createNode([4,2,1,3,5])
        let node = instance.createNode([-1,5,3,4, 0])
        var ret = instance.sortList(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}


/*
 在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。
 
 示例 1:
 
 输入: 4->2->1->3
 输出: 1->2->3->4
 示例 2:
 
 输入: -1->5->3->4->0
 输出: -1->0->3->4->5
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/sort-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
