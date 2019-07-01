//
//  LinkList_147_Insertion_Sort_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_147_Insertion_Sort_List: LeetCode_LinkList {
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        guard head != nil else {
            return head
        }
        //弄一个虚拟节点，头节点变动的时候不用考虑头结点
        let newHead = ListNode(0)
        newHead.next = head
        
        var cur = head?.next  //外循环的循环节点
        var pre = head
        
        while cur != nil {
            let temp  = cur?.next  //保存下一个节点
            
            var curInsert = newHead.next
            var preInsert: ListNode? = newHead //循环节点的前一个节点
            while curInsert !== cur {
                if curInsert!.val > cur!.val {//找到了插入的位置
                    break
                }
                preInsert = preInsert?.next
                curInsert = curInsert?.next
            }
            
            if cur !== curInsert {  //插入吧
                cur?.next = curInsert
                preInsert?.next = cur
                
                pre?.next = temp
            } else {  //不需要插入，是最大的
                //循环条件递推
                pre = cur
            }
            cur  = temp
        }
        return newHead.next
    }
    static func testinsertionSortList() {
        let  instance = LinkList_147_Insertion_Sort_List()
//        let node = instance.createNode([4,2,1,3])
        let node = instance.createNode([-1,5,3,4, 0])
        var ret = instance.insertionSortList(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}


/*
 对链表进行插入排序。
 
 
 插入排序的动画演示如上。从第一个元素开始，该链表可以被认为已经部分排序（用黑色表示）。
 每次迭代时，从输入数据中移除一个元素（用红色表示），并原地将其插入到已排好序的链表中。
 
   
 
 插入排序算法：
 
 插入排序是迭代的，每次只移动一个元素，直到所有元素可以形成一个有序的输出列表。
 每次迭代中，插入排序只从输入数据中移除一个待排序的元素，找到它在序列中适当的位置，并将其插入。
 重复直到所有输入数据插入完为止。
   
 
 示例 1：
 
 输入: 4->2->1->3
 输出: 1->2->3->4
 示例 2：
 
 输入: -1->5->3->4->0
 输出: -1->0->3->4->5
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/insertion-sort-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
