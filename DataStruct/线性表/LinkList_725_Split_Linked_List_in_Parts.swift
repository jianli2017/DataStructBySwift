//
//  LinkList_725_Split_Linked_List_in_Parts.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_725_Split_Linked_List_in_Parts: LeetCode_LinkList {
    func splitListToParts(_ root: ListNode?, _ k: Int) -> [ListNode?] {
        var count = 0
        var cur = root
        var num = 0
        var res = 0
        var result:[ListNode?] = Array(repeating: nil, count: k)
        
        while cur != nil {
            count += 1
            cur = cur?.next
        }
        
        num = count/k
        res = count%k
        cur = root  //外循环变量
        for i in 0..<k {
            let head = ListNode(0)
            var last: ListNode?
            
            var p: ListNode? = head  //内循环的 循环变量
            for _ in 0 ..< num {
                p?.next = cur  //新链表添加元素
                p = p?.next
                last = cur
                cur = cur?.next
            }
            
            if res > 0 && cur != nil {
                last = p
                p?.next = cur  //p 不需要后移了
                last = cur
                cur = cur?.next
                res -= 1
            }
            
            if last != nil {
                last?.next = nil
            }
            result[i] = head.next
        }
        return result

    }
    
    static func testSplitListToParts() {
        let  instance = LinkList_725_Split_Linked_List_in_Parts()
        let node1 = instance.createNode([1,2,3,4,5,6,7])
        var ret = instance.splitListToParts(node1?.next, 3)
//        while ret != nil {
//            print("最终结果：  ret")
//        }
    }
}



/*
 给定一个头结点为 root 的链表, 编写一个函数以将链表分隔为 k 个连续的部分。
 
 每部分的长度应该尽可能的相等: 任意两部分的长度差距不能超过 1，也就是说可能有些部分为 null。
 
 这k个部分应该按照在链表中出现的顺序进行输出，并且排在前面的部分的长度应该大于或等于后面的长度。
 
 返回一个符合上述规则的链表的列表。
 
 举例： 1->2->3->4, k = 5 // 5 结果 [ [1], [2], [3], [4], null ]
 
 示例 1：
 
 输入:
 root = [1, 2, 3], k = 5
 输出: [[1],[2],[3],[],[]]
 解释:
 输入输出各部分都应该是链表，而不是数组。
 例如, 输入的结点 root 的 val= 1, root.next.val = 2, \root.next.next.val = 3, 且 root.next.next.next = null。
 第一个输出 output[0] 是 output[0].val = 1, output[0].next = null。
 最后一个元素 output[4] 为 null, 它代表了最后一个部分为空链表。
 示例 2：
 
 输入:
 root = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], k = 3
 输出: [[1, 2, 3, 4], [5, 6, 7], [8, 9, 10]]
 解释:
 输入被分成了几个连续的部分，并且每部分的长度相差不超过1.前面部分的长度大于等于后面部分的长度。
   
 
 提示:
 
 root 的长度范围： [0, 1000].
 输入的每个节点的大小范围：[0, 999].
 k 的取值范围： [1, 50].
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/split-linked-list-in-parts
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
