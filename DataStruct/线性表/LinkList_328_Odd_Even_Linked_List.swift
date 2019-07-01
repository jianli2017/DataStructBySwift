//
//  LinkList_328_Odd_Even_Linked_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/28.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_328_Odd_Even_Linked_List: LeetCode_LinkList {
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        let firstHead = ListNode(0)
        let secondHead = ListNode(0)
        
        var cur = head
        var first: ListNode? = firstHead
        var second: ListNode? = secondHead
        
        while cur != nil {
            let next = cur?.next?.next
            
            //处理奇数
            first?.next = cur
            first = first?.next

            //处理偶数
            second?.next = cur?.next
            second = second?.next
            
            cur = next //循环条件递增
        }
        
        first?.next = secondHead.next
        return firstHead.next
    }
    
    static func testOddEvenList() {
        let  instance = LinkList_328_Odd_Even_Linked_List()
        let node = instance.createNode([1,2,3,4,5])
//        let node = instance.createNode([2,1,3,5,6,4,7])
        var ret = instance.oddEvenList(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}
/*
    给定一个单链表，把所有的奇数节点和偶数节点分别排在一起。请注意，这里的奇数节点和偶数节点指的是节点编号的奇偶性，而不是节点的值的奇偶性。

请尝试使用原地算法完成。你的算法的空间复杂度应为 O(1)，时间复杂度应为 O(nodes)，nodes 为节点总数。

示例 1:

输入: 1->2->3->4->5->NULL
输出: 1->3->5->2->4->NULL
示例 2:

输入: 2->1->3->5->6->4->7->NULL
输出: 2->3->6->7->1->5->4->NULL
说明:

应当保持奇数节点和偶数节点的相对顺序。
链表的第一个节点视为奇数节点，第二个节点视为偶数节点，以此类推。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/odd-even-linked-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
